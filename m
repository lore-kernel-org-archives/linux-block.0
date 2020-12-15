Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BBC4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A1222285
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgLOGwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:52:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53402 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgLOGwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 01:52:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BF6is6M148114;
        Tue, 15 Dec 2020 06:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hWNv+8anIIHJLipXorRUdbi/P7w01QGEiTaQOHF82Ao=;
 b=Y2r4yTbFIa+AB/85r4gwMctBmSkhL+nhCv+hzacMi32tDWsfpGG7sdADNUKwHfF2J/Zx
 N+Wac28vf3iQDVNfaTcm4cp9kNIWcyuKF9z71Q3MbFc0/WeHqC4jjrSw2b1QQ20R4Ozu
 iL9vday0zAf2n7dmlu664svMuR2+fMJhycXqFlOY023ZN6ZmNWiW/euPUF0cOptJ0haP
 q92v3Lglj7rvgCLoJ+hQd930XLaboJtXD0fC+5DwYoK4Zr3Z72MWoq8tenFwkzov3znK
 9gT8mSeDpW0hQSTUBw83FIwLZ5EFuG+N+DvJW5QW0BOpKdUfGGjCqECmJGeif9csSDVZ rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35cn9r8xk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 06:51:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BF6e6Iq070502;
        Tue, 15 Dec 2020 06:51:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35d7svqjj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 06:51:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BF6pROv024807;
        Tue, 15 Dec 2020 06:51:28 GMT
Received: from [192.168.1.10] (/180.164.31.21)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 22:51:27 -0800
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>, hch@lst.de
Cc:     "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>, dm-devel@redhat.com
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com> <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com> <20201211163049.GC16168@redhat.com>
 <1ee7652e-b77f-6fa4-634c-ff6639037321@kernel.dk>
 <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <cdc3c792-17ac-de61-12ae-74691769fc3c@oracle.com>
Date:   Tue, 15 Dec 2020 14:51:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150045
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Folks,

On 12/12/20 12:56 AM, Hannes Reinecke wrote:
> On 12/11/20 5:33 PM, Jens Axboe wrote:
>> On 12/11/20 9:30 AM, Mike Snitzer wrote:
>>> While I still think there needs to be a proper _upstream_ consumer of
>>> blk_interposer as a condition of it going in.. I'll let others make the
>>> call.
>>
>> That's an unequivocal rule.
>>
>>> As such, I'll defer to Jens, Christoph and others on whether your
>>> minimalist blk_interposer hook is acceptable in the near-term.
>>
>> I don't think so, we don't do short term bandaids just to plan on
>> ripping that out when the real functionality is there. IMHO, the dm
>> approach is the way to go - it provides exactly the functionality that
>> is needed in an appropriate way, instead of hacking some "interposer"
>> into the core block layer.
>>
> Which is my plan, too.
> 
> I'll be working with the Veeam folks to present a joint patchset (including the DM bits) for the next round.
> 

Besides the dm approach, do you think Veeam's original requirement is a good
use case of "block/bpf: add eBPF based block layer IO filtering"?
https://lwn.net/ml/bpf/20200812163305.545447-1-leah.rumancik@gmail.com/

Thanks,
Bob
