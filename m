Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32518C433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 01:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC7861284
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 01:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhKSBx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:53:28 -0500
Received: from pv50p00im-ztdg10022001.me.com ([17.58.6.58]:33552 "EHLO
        pv50p00im-ztdg10022001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232967AbhKSBx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 20:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1637286627;
        bh=BSbFce/h/GBa2nVTyfybsr361g4utAySlsL0pTR1A10=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=o6K5V3kqhYUtBqjn8J3Msxns2ewDkEPQ7ZbNSma9ud47CkhvxK8YIFMmzR7cNVdPI
         VHuFX8n1zcPFjZqLk0riaKoHu67SPjgGMPXt+wytJp5cqlKv3yYacnYbzVaYwJ1ve9
         0wMfoaoKUasAd5zUAwEM9pVpgdBwazRhtZK5wrX6bmJ6KiBAYNJn7U/igGYhnNwR+p
         a8qSt149iO9Mcqe/nNn+wKVZIzQHSJXUyBSF9UapJVO5i7vkBc4MgC982B0IX8H0uf
         887K4cE46Ocor38yra1j+0chSrs78W+04H6MFCLeHNdXXrmsrLwK7m8otDGWgSgExX
         NzXze90EBCaQQ==
Received: from smtpclient.apple (unknown [122.96.45.34])
        by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 4CB40A046A;
        Fri, 19 Nov 2021 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   wangyangbo <yangbonis@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] loop: mask loop_control_ioctl parameter only as minor
Date:   Fri, 19 Nov 2021 09:50:14 +0800
Message-Id: <94A72A7C-0E1A-4C61-ADDE-9BACEA91FDB5@icloud.com>
References: <c685d6dc-3918-6ee5-df59-f2d814635228@I-love.SAKURA.ne.jp>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c685d6dc-3918-6ee5-df59-f2d814635228@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Mailer: iPhone Mail (19B74)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-19_01:2021-11-17,2021-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=895 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111190006
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Nov 18, 2021, at 22:15, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.j=
p> wrote:
>=20
> =EF=BB=BFOn 2021/11/18 11:36, wangyangbo wrote:
>> @@ -2170,11 +2170,11 @@ static long loop_control_ioctl(struct file *file,=
 unsigned int cmd,
>> {
>>    switch (cmd) {
>>    case LOOP_CTL_ADD:
>> -        return loop_add(parm);
>> +        return loop_add(MINOR(parm));
>=20
> Better to return -EINVAL or something if out of minor range?
Definitely, EINVAL or EDOM, which do you think is better?

>=20
>>    case LOOP_CTL_REMOVE:
>> -        return loop_control_remove(parm);
>> +        return loop_control_remove(MINOR(parm));
>=20
> This is bad, for this change makes
>=20
>    if (idx < 0) {
>        pr_warn("deleting an unspecified loop device is not supported.\n");=

>        return -EINVAL;
>    }
>=20
> dead code by masking the argument to 0-1048575 range.

But ioctl param is unsigned long, I think this need to sanitize.

>>    case LOOP_CTL_GET_FREE:
>> -        return loop_control_get_free(parm);
>> +        return loop_control_get_free(MINOR(parm));
>=20
> This is pointless, for the passed argument is not used.
> By the way, didn't someone already propose removal of this argument?

I don't find this in mail list, but I would like to sanitize that code.=
