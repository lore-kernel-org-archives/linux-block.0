Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3E5C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 04:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC56238E9
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 04:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhANEvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 23:51:06 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35136 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhANEvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 23:51:06 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210114045023epoutp01f57477e99475d6b817320a02504f0a23~aAAGBFjBK2352523525epoutp01c
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 04:50:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210114045023epoutp01f57477e99475d6b817320a02504f0a23~aAAGBFjBK2352523525epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610599823;
        bh=wLk8WIcs3xZIInruRgtogZFWj3nDh+ziXMVKxJi0Clc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRvn7+fZv1NokJKLajIUKt/dM7HNtArDaqPvT8ioWaeZYnJQuGekpeqT3Al3CzU08
         cz0Dfyc3nusxKEB66LhxOWCYDHEk4G5phW/dxvPS3PBH7jrAkvBwh4PeE0qcVj3Aj1
         GAce6O7/79ZHdm+xAQZQqFVpHfnnD1yDFR0gHBrQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210114045022epcas1p4aeb7e6e980f6f8934ba1cfa6eb36519d~aAAFCemF51578215782epcas1p4q;
        Thu, 14 Jan 2021 04:50:22 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DGX1S54kZz4x9Q6; Thu, 14 Jan
        2021 04:50:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.2A.63458.C8DCFFF5; Thu, 14 Jan 2021 13:50:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210114045019epcas1p16d4f5f258c2a3b290540ac640745764d~aAAC7ysP50535205352epcas1p1w;
        Thu, 14 Jan 2021 04:50:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210114045019epsmtrp24e796e4409da20dfcb58311eac85fbb1~aAAC5hmIy2608226082epsmtrp2w;
        Thu, 14 Jan 2021 04:50:19 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-74-5fffcd8cf35e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.3C.08745.B8DCFFF5; Thu, 14 Jan 2021 13:50:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210114045019epsmtip126a3a7e726cfca7cfeeaea65166d22de~aAACrExER1886518865epsmtip1u;
        Thu, 14 Jan 2021 04:50:19 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com
Cc:     Johannes.Thumshirn@wdc.com, axboe@kernel.dk,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH] bio: limit bio max size.
Date:   Thu, 14 Jan 2021 13:35:10 +0900
Message-Id: <20210114043510.7379-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <BL0PR04MB651470CA7B3AA843E57AF85EE7A80@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmrm7P2f/xBh1fFS1W3+1ns2ht/8Zk
        0fOkidXib9c9JouvD4st9t7Stri8aw6bxaHJzUwW0zfPYba4dv8Mu8W5k59YLeY9drD4tfwo
        o8X7H9fZLU7tmMxssX7vTzYHAY+ds+6ye1w+W+qxaVUnm8f7fVfZPPq2rGL0+LxJzqP9QDdT
        AHtUjk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0OVK
        CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAJDgwK94sTc4tK8dL3k/FwrQwMDI1Og
        yoScjF/PFzAW3HKoaOt+xd7A+EWvi5GTQ0LAROLs5fesXYxcHEICOxglNr79zgbhfGKU2LZg
        ATOE85lRon//cWaYlo3rfrJDJHYxSrSdu8gOkgCralpWCGKzCehI9L29xQZiiwhISpx6+QVs
        LLPALyaJ3ZNusHQxcnAIC+hKrGiSBalhEVCV+HR7MiNImFfASmLehGqIXfIST3uXg+3lFIiV
        aHi6lxHE5hUQlDg58wkLiM0MVNO8dTbYoRICezgkdj/5yQ7R7CJxbv0yqKOFJV4d3wIVl5L4
        /G4vG0RDN6NEc9t8RghnAqPEkufLmCCqjCU+ff4MdhGzgKbE+l36EGFFiZ2/5zJCbOaTePe1
        hxWkREKAV6KjTQiiREXiTMt9Zphdz9fuhJroIbGpaTojJKw2MErMW247gVFhFpJ/ZiH5ZxbC
        4gWMzKsYxVILinPTU4sNC4yQY3gTIzgpa5ntYJz09oPeIUYmDsZDjBIczEoivEXdf+OFeFMS
        K6tSi/Lji0pzUosPMZoCA3sis5Rocj4wL+SVxBuaGhkbG1uYmJmbmRorifMmGjyIFxJITyxJ
        zU5NLUgtgulj4uCUamCKXPTgwNntVT2uW6esrgqKXH6q7FvbgpOrON5/6y5mMBTeFVf1myWs
        LZHrxZL7P5bwXfm4OP05Z3nM4j32ZUc3zMp3Oe+wVF9m/u59F1QfRzKffPBNVyeiy9ne0FvB
        bMfy4voV+ydMe3TfeN2L6Z7Lvy2tqFmat7rfsWOXtPVMe9U3dx9eMPuY0VHUukHz8OH5dV1V
        MzxPZLY81jc6/e2Etd+2sqxXc/amrdIuEoufwX//5ySdcNtldh+N7BbvSaq+dfxRxG/bCSkq
        92bYblKunLfH80HWRktnwwbxkr9uHTZrTkx1jD6gdfPxZIYiT47k6ReyQq62n3fm+lZSs7NS
        IbXkh++57vNX6lqd9u9QU2Ipzkg01GIuKk4EAAHMXSlTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnG732f/xBh0vdS1W3+1ns2ht/8Zk
        0fOkidXib9c9JouvD4st9t7Stri8aw6bxaHJzUwW0zfPYba4dv8Mu8W5k59YLeY9drD4tfwo
        o8X7H9fZLU7tmMxssX7vTzYHAY+ds+6ye1w+W+qxaVUnm8f7fVfZPPq2rGL0+LxJzqP9QDdT
        AHsUl01Kak5mWWqRvl0CV8av5wsYC245VLR1v2JvYPyi18XIySEhYCKxcd1P9i5GLg4hgR2M
        Ei0Xz7NBJKQkjp94y9rFyAFkC0scPlwMUfORUWLBosMsIDVsAjoSfW9vgdWLCEhKnHr5hQ2k
        iFmgh1li299edpBmYQFdiRVNsiA1LAKqEp9uT2YECfMKWEnMm1ANsUpe4mnvcmYQm1MgVqLh
        6V5GEFtIIEZiwuxLYHFeAUGJkzOfgK1lBqpv3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5xYb
        FhjlpZbrFSfmFpfmpesl5+duYgRHjpbWDsY9qz7oHWJk4mA8xCjBwawkwlvU/TdeiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbJZqffBUyUWlE9teVI
        qkh18n/W1YmmNqvTg94ml7Nv8P787cemrvOJb6Y/V2X9tVSi737nZ58QD5FrxZp8ey9/tVao
        /1451XzJYc/8NwEaN3/uZtm54rjaf6POLKad+ztjrX84G/Vbywq9SqmYfOjU91+zvqxqN+pl
        mPFKqSDKWvccvwVb/I3lN4qZ7pcq58p9OFa65vv8aD/z6Y5bHI80XHHeO3WyD7NCS8MnEd+Z
        ncuzc3Y93n0tpCjk39ukFdzM+5oY9V9MflviU2Vw/lT0tx27l7txaFY2Str+CpNKWi7e8YlV
        Y8ZpL5dVT5fp/yvMuSJ85fpir+iMdSs09VxWWN7/EuhUmiMz72RCiqISS3FGoqEWc1FxIgDb
        TjIbCwMAAA==
X-CMS-MailID: 20210114045019epcas1p16d4f5f258c2a3b290540ac640745764d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210114045019epcas1p16d4f5f258c2a3b290540ac640745764d
References: <BL0PR04MB651470CA7B3AA843E57AF85EE7A80@BL0PR04MB6514.namprd04.prod.outlook.com>
        <CGME20210114045019epcas1p16d4f5f258c2a3b290540ac640745764d@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>On 2021/01/14 12:53, Ming Lei wrote:
>> On Wed, Jan 13, 2021 at 12:02:44PM +0000, Damien Le Moal wrote:
>>> On 2021/01/13 20:48, Ming Lei wrote:
>>>> On Wed, Jan 13, 2021 at 11:16:11AM +0000, Damien Le Moal wrote:
>>>>> On 2021/01/13 19:25, Ming Lei wrote:
>>>>>> On Wed, Jan 13, 2021 at 09:28:02AM +0000, Damien Le Moal wrote:
>>>>>>> On 2021/01/13 18:19, Ming Lei wrote:
>>>>>>>> On Wed, Jan 13, 2021 at 12:09 PM Changheun Lee <nanich.lee@samsung.com> wrote:
>>>>>>>>>
>>>>>>>>>> On 2021/01/12 21:14, Changheun Lee wrote:
>>>>>>>>>>>> On 2021/01/12 17:52, Changheun Lee wrote:
>>>>>>>>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.
>>>>>>>>>>>>> but sometimes it would lead to inefficient behaviors.
>>>>>>>>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user space -
>>>>>>>>>>>>> all pages for 64MB would be merged to a bio structure if memory address is
>>>>>>>>>>>>> continued phsycally. it makes some delay to submit until merge complete.
>>>>>>>>>>>>> bio max size should be limited as a proper size.
>>>>>>>>>>>>
>>>>>>>>>>>> But merging physically contiguous pages into the same bvec + later automatic bio
>>>>>>>>>>>> split on submit should give you better throughput for large IOs compared to
>>>>>>>>>>>> having to issue a bio chain of smaller BIOs that are arbitrarily sized and will
>>>>>>>>>>>> likely need splitting anyway (because of DMA boundaries etc).
>>>>>>>>>>>>
>>>>>>>>>>>> Do you have a specific case where you see higher performance with this patch
>>>>>>>>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and too small
>>>>>>>>>>>> considering that many hardware can execute larger IOs than that.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> When I tested 32MB chunk read with O_DIRECT in android, all pages of 32MB
>>>>>>>>>>> is merged into a bio structure.
>>>>>>>>>>> And elapsed time to merge complete was about 2ms.
>>>>>>>>>>> It means first bio-submit is after 2ms.
>>>>>>>>>>> If bio size is limited with 1MB with this patch, first bio-submit is about
>>>>>>>>>>> 100us by bio_full operation.
>>>>>>>>>>
>>>>>>>>>> bio_submit() will split the large BIO case into multiple requests while the
>>>>>>>>>> small BIO case will likely result one or two requests only. That likely explain
>>>>>>>>>> the time difference here. However, for the large case, the 2ms will issue ALL
>>>>>>>>>> requests needed for processing the entire 32MB user IO while the 1MB bio case
>>>>>>>>>> will need 32 different bio_submit() calls. So what is the actual total latency
>>>>>>>>>> difference for the entire 32MB user IO ? That is I think what needs to be
>>>>>>>>>> compared here.
>>>>>>>>>>
>>>>>>>>>> Also, what is your device max_sectors_kb and max queue depth ?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 32MB total latency is about 19ms including merge time without this patch.
>>>>>>>>> But with this patch, total latency is about 17ms including merge time too.
>>>>>>>>
>>>>>>>> 19ms looks too big just for preparing one 32MB sized bio, which isn't
>>>>>>>> supposed to
>>>>>>>> take so long.  Can you investigate where the 19ms is taken just for
>>>>>>>> preparing one
>>>>>>>> 32MB sized bio?
>>>>>>>
>>>>>>> Changheun mentioned that the device side IO latency is 16.7ms out of the 19ms
>>>>>>> total. So the BIO handling, submission+completion takes about 2.3ms, and
>>>>>>> Changheun points above to 2ms for the submission part.
>>>>>>
>>>>>> OK, looks I misunderstood the data.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> It might be iov_iter_get_pages() for handling page fault. If yes, one suggestion
>>>>>>>> is to enable THP(Transparent HugePage Support) in your application.
>>>>>>>
>>>>>>> But if that was due to page faults, the same large-ish time would be taken for
>>>>>>> the preparing the size-limited BIOs too, no ? No matter how the BIOs are diced,
>>>>>>> all 32MB of pages of the user IO are referenced...
>>>>>>
>>>>>> If bio size is reduced to 1MB, just 256 pages need to be faulted before submitting this
>>>>>> bio, instead of 256*32 pages, that is why the following words are mentioned:
>>>>>>
>>>>>> 	It means first bio-submit is after 2ms.
>>>>>> 	If bio size is limited with 1MB with this patch, first bio-submit is about
>>>>>> 	100us by bio_full operation.
>>>>>
>>>>> Yes, but eventually, all pages for the 32MB IO will be faulted in, just not in
>>>>> one go. Overall number of page faults is likely the same as with the large BIO
>>>>> preparation. So I think we are back to my previous point, that is, reducing the
>>>>> device idle time by starting a BIO more quickly, even a small one, leads to
>>>>> overlap between CPU time needed for the next BIO preparation and previous BIO
>>>>> execution, reducing overall the latency for the entire 32MB user IO.
>>>>
>>>> When bio size is reduced from 32M to 1M:
>>>>
>>>> 1MB/(P(1M) + D(1M)) may become bigger than 32MB/(P(1M) + D(1M)), so
>>>> throughput is improved.
>>>
>>> I think that the reason is that P(1M) < D(1M) and so there is overlap between P
>>> and D: P of the next BIO is done on the CPU while D of the previous BIO is
>>> ongoing on the device, assuming there is no plugging.
>> 
>> Looks you are talking about AIO. IMO, if AIO is used in Changheun's
>> test, the UFS controller pipeline can be saturated easily by many
>> enough(> 8 or more) 32M requests(preparing each takes 2ms, and device need
>> 16ms to handle 32MB req), then there shouldn't be such issue.
>> 
>> So I guess Changheun uses sync dio, and the 2ms preparing time is added
>> to bio submission delay every time.
>> 
>> Changheun, can you talk about your 32MB block size direct IO test in a
>> bit detail? AIO or sync dio? Do you have fio command line to reproduce
>> this issue?
>
>Maybe also provide a blktrace output of for one 32MB IO execution ?

When 32MB chunk read with direct I/O option is comming from userspace,
kernel behavior is below now. it's timeline.

 | bio merge for 32MB. total 8,192 pages are merged.
 | total elapsed time is over 2ms.
 |------------------ ... ----------------------->|
                                                 | 8,192 pages merged a bio.
                                                 | at this time, first bio submit is done.
                                                 | 1 bio is split to 32 read request and issue.
                                                 |--------------->
                                                  |--------------->
                                                   |--------------->
                                                              ......
                                                                   |--------------->
                                                                    |--------------->|
                                                                                     | 
                          total 19ms elapsed to complete 32MB read done from device. |

If bio max size is limited with 1MB, behavior is changed below.

 | bio merge for 1MB. 256 pages are merged for each bio.
 | total 32 bio will be made.
 | total elapsed time is over 2ms. it's same.
 | but, first bio submit timing is fast. about 100us.
 |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
      | 256 pages merged a bio.
      | at this time, first bio submit is done.
      | and 1 read request is issued for 1 bio.
      |--------------->
           |--------------->
                |--------------->
                                      ......
                                                 |--------------->
                                                  |--------------->|
                                                                   | 
        total 17ms elapsed to complete 32MB read done from device. | 


As a result, read request issue timing is faster if bio max size is limited.
Current kernel behavior with multipage bvec, super large bio can be created.
And it lead to delay first I/O request issue.

>
>> 
>> 
>> Thanks, 
>> Ming
>> 
>> 
>
>
>-- 
>Damien Le Moal
>Western Digital Research
>
