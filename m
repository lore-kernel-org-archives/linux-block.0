Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E21C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 22:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B2222A1
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 22:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfBOWOP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:14:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:46834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfBOWOP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 17:14:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC150ACB5;
        Fri, 15 Feb 2019 22:14:11 +0000 (UTC)
Subject: Re: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "hch@infradead.org" <hch@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "tytso@mit.edu" <tytso@mit.edu>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <2ed684c6-38de-1717-5787-31b00c72ba4f@suse.de>
From:   Lee Duncan <lduncan@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lduncan@suse.com; prefer-encrypt=mutual; keydata=
 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
 a7PzlXQ=
Organization: SUSE
Message-ID: <a163a2c6-07f4-206e-d251-9af08adf9f21@suse.com>
Date:   Fri, 15 Feb 2019 14:14:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <2ed684c6-38de-1717-5787-31b00c72ba4f@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/19 2:32 AM, Johannes Thumshirn wrote:
> On 06/02/2019 06:21, Chaitanya Kulkarni wrote:
>> Hi,
>>
>> Since discussion of the storage stack and device driver at the LSFMM 2017
>> (https://lwn.net/Articles/717699/),  Omar Sandoval introduced a new framework
>> "blktests" dedicated for Linux Kernel Block layer testing.
>> (https://lwn.net/Articles/722785/, https://github.com/osandov/blktests).
>>  
>> As Linux Kernel Block layer is central to the various file systems and underlying
>> low-level device drivers it is important to have a centralized testing framework and
>> make sure it grows with the latest block layer changed which are being added based
>> on the different device features from different device types
>> (e.g. NVMe devices with Zoned Namespace support).
>>
>> Since then blktests has grown and became go-to framework where we have integrated
>> different stand-alone test suites like SRP-tests, NVMFTESTS, NVMe Multipath tests,
>> zone block device tests, into one central framework, which has made an overall block layer
>> testing and development much easier than having to configure and execute different
>> test cases for each kernel release for different subsystems such as FS, NVMe,
>> Zone Block devices, etc). 
>>
>> Here is the list of the existing test categories:-
>>
>> ├── block                                           28 Tests
>> ├── loop                                             07 Tests
>> ├── meta                                            12 Tests
>> ├── nbd                                              02 Tests
>> ├── nvme                                           28 Tests
>> ├── nvmeof-mp                                  12 Tests
>> ├── scsi                                              06 Tests
>> ├── srp                                               13 Tests
>> └── zbd                                              05 Tests
>> ---------------------------------------------------------------- 
>>            9 Categories                            ~110 Tests
>>
>> This project has gathered much attention and storage stack community is actively
>> participating and adding new test cases with different categories to the framework. 
>>
>> For storage track, we would like to propose a session dedicated to blktests. It is a great
>> opportunity for the storage developers to gather and have a discussion about:-
>>
>> 1. Current status of the blktests framework.
>> 2. Any new/missing features that we want to add in the blktests.
>> 3. Any new kernel features that could be used to make testing easier?
>> E.g. Implementing new features in the null_blk.c in order to have device
>> independent complete test coverage. (e.g. adding discard command for null_blk or any
>> other specific REQ_OP). Discussion about having any new tracepoint events in the block layer.
>> 4. Any new test cases/categories which are lacking in the blktests framework.
> 
> One thing I'd love to see is more hardware/driver specific tests. I'm
> sure Broadcom, Marvell, Huawei and all the others out there do have test
> suites for their HBA drivers but not a single one of these tests is
> publicly available.

I said this same thing 3 (?) years ago, but then I was told to go out
and solve it. :) Dealing with multiple manufactures could be a full-time
job.

> 
> We're also lacking tests for things like ioprio, persistent reservation,
> bcache and so on.

I have a test suite for persistent reservations, but would love help in
adding it to this test suite.

> 
> Adding support for collecting gcov information after running a test case
> would also be awesome (this is missing in xfstests as well).
> 
> So I think a session on blktests can help us get the gap closed.
> 
> Byte,
> 	Johannes
> 

I also would love to attend such a session.
-- 
Lee Duncan
