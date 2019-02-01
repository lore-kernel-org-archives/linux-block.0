Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A7DC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 16:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0C320818
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 16:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfBAQDx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:03:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQDw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Feb 2019 11:03:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8382FD7929;
        Fri,  1 Feb 2019 16:03:52 +0000 (UTC)
Received: from o.ww.redhat.com (ovpn-117-19.ams2.redhat.com [10.36.117.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27A9660C61;
        Fri,  1 Feb 2019 16:03:41 +0000 (UTC)
Subject: Re: [dm-devel] block: Fix a WRITE SAME BUG_ON
To:     John Dorminy <jdorminy@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Alasdair G Kergon <agk@redhat.com>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
 <20190131103924.GA22503@infradead.org>
 <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
 <20190201073527.GA14758@infradead.org>
 <CAMeeMh-wAZ8377sMrnyQZUt2HT1hB02DHSROJURLmPsaZPkeQQ@mail.gmail.com>
From:   Heinz Mauelshagen <heinzm@redhat.com>
Message-ID: <f7b05928-316c-4c73-b04b-bba38ea60b27@redhat.com>
Date:   Fri, 1 Feb 2019 17:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMeeMh-wAZ8377sMrnyQZUt2HT1hB02DHSROJURLmPsaZPkeQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 01 Feb 2019 16:03:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/19 3:09 PM, John Dorminy wrote:
> I didn't know such a thing existed... does it work on any block
> device? Where do I read more about this?


Use sg_write_same(8) from package sg3_utils.

For instance 'sg_write_same --in=foobarfile --lba=0 --num=20000 
--xferlen=512 /dev/sdwhatever'

will read the pattern to write same from file 'foobarfile' with length 
explicitely set to 512 bytes
(rather than derived from foobarfile's size) and write it 20000 times 
starting at LBA 0 to /dev/sdwhatever.

> --lba=
>
> On Fri, Feb 1, 2019 at 2:35 AM Christoph Hellwig <hch@infradead.org> wrote:
>> On Thu, Jan 31, 2019 at 02:41:52PM -0500, John Dorminy wrote:
>>>> On Wed, Jan 30, 2019 at 09:08:50AM -0500, John Dorminy wrote:
>>>>> (I use WRITE_SAME to fill devices with a particular pattern in order
>>>>> to catch failures to initialize disk structures appropriately,
>>>>> personally, but it's just for convenience/speed.)
>>>> How do you use it?  We don't have a user interface to generate
>>>> REQ_OP_WRITE_SAME requests.
>>> A not-checked-in test module, similar to Zhang Xiaoxu's reproducer,
>>> exposing a sysfs node to trigger filling a block device with a test
>>> pattern.
>> Any reason you don't just use SCSI/NVMe passthrough directly from
>> userspace for that?
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel

