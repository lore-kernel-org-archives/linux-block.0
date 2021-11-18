Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E32C433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1ED6126A
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 15:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhKRPYP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:24:15 -0500
Received: from pv50p00im-ztdg10011201.me.com ([17.58.6.39]:51502 "EHLO
        pv50p00im-ztdg10011201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhKRPYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 10:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1637248874;
        bh=50VGtQMcHrDKEt2kB+jvAXr6qvwaTbHf5f0uqw/EvSQ=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=p6gklQjaAeM2ZZSwJnpjBjK4B9eOzZuroBmOUEHZSUhnYtNfMDlVr8xth8XQJ5RoU
         mHGfHxgh//UqCDoPZXrkfa47grs3P6rH4sZKmVJTW0utZSTfWXoWszBDFNW1bt22Mt
         FQ3XuwHwRunR6uTS7Wp8OkZGKrB3RfMli3YkZfQjASwhbkffN0iOlBjs0EjwCW+PQL
         HjI5cLzWrzHK7cqPEJxlD7fq6x2bmFWd1nuH5uJfy8rP+LDzGnWnmLc0JR3sczZeb6
         X23Di5PHKRTPaJNwKd/buCcgPJ5bQCgmIFR3GdrAPyTOR9dVt1UiE9KOldBp+CFPrG
         cZWcDBX77FrHA==
Received: from smtpclient.apple (unknown [122.96.45.34])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 05DAC2A032A;
        Thu, 18 Nov 2021 15:21:13 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   wang yangbo <yangbonis@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] loop: mask loop_control_ioctl parameter only as minor
Date:   Thu, 18 Nov 2021 23:21:11 +0800
Message-Id: <14AB9129-59F6-4DFA-8591-2C11BB641D5F@icloud.com>
References: <1ebd5c91-442c-1ab0-f71f-0feff04e37f5@i-love.sakura.ne.jp>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        axboe@kernel.dk
In-Reply-To: <1ebd5c91-442c-1ab0-f71f-0feff04e37f5@i-love.sakura.ne.jp>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Mailer: iPhone Mail (19B74)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-18_12:2021-11-17,2021-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=785 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111180085
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Nov 18, 2021, at 22:51, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.j=
p> wrote:
>=20
> =EF=BB=BFOn 2021/11/18 23:15, Tetsuo Handa wrote:
>>> On 2021/11/18 11:36, wangyangbo wrote:
>>> @@ -2170,11 +2170,11 @@ static long loop_control_ioctl(struct file *file=
, unsigned int cmd,
>>> {
>>>    switch (cmd) {
>>>    case LOOP_CTL_ADD:
>>> -        return loop_add(parm);
>>> +        return loop_add(MINOR(parm));
>>=20
>> Better to return -EINVAL or something if out of minor range?
>=20
> Well, this is not specific to loop devices.
> Shouldn't the minor range be checked by device_add_disk() ?
I just think ioctl paramter need to make sense.=20

Perhaps block layer need add/update/del check for consistency, but as inner i=
nterface caller check is also agreeable.

By the way, do other driver have similar problems?

