Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FC3C4360F
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1290320851
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hh2Kqrb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbfCAOOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:14:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfCAOOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Mar 2019 09:14:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x21EE33t073057;
        Fri, 1 Mar 2019 14:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=74z5267vdgm1m+aeUgmzm1szV69XtciQOvFQkQQ1jmQ=;
 b=Hh2Kqrb0jF9w1IWw69zsyaA6Yjch3hWGUdXGzQjGuXniCjLoQKHwqxxEpg/aN8M3FzFZ
 llti+MlhNwuaoPc1ftDRAu+odhYAociu2qlfenKPG3TrrqvS7LIw55iLVFaEvcxn8DIs
 hajWaXNlgy3NoSq4PzI9+ugJm8tPHMUdH2ITi4F/JiT4LHnriQ/Vj9i/ahJZirSgtEjm
 16Nznn6pzVsPydWv4RkMBB5+VTCHJmGEdcqtIFqolDR5W6WoIgkshdA+Zc+nwSFGQeA/
 omawxUGopUSIbWlKPx+phZC3imCAhdt7IJtiSXhj3mslCYigO7eeXIGjT5XA6FPs/riz uw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qtxts7f11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Mar 2019 14:14:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x21EEgol019654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 14:14:42 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x21EEfVe006294;
        Fri, 1 Mar 2019 14:14:41 GMT
Received: from [192.168.1.12] (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Mar 2019 06:14:41 -0800
Subject: Re: [RFC PATCH v2 0/9] Block/XFS: Support alternative mirror device
 retry
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        shirley.ma@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>,
        darrick.wong@oracle.com, hch@infradead.org
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190218213150.GE14116@dastard>
 <ba78a587-04ba-58a4-f282-63e200c81e2d@oracle.com>
 <D0A57CD2-1EE2-43C9-9E79-7B09F4FCEAC6@dilger.ca>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <f6612507-128e-85d1-9045-60af6c87f73e@oracle.com>
Date:   Fri, 1 Mar 2019 22:14:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <D0A57CD2-1EE2-43C9-9E79-7B09F4FCEAC6@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903010100
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/19 7:28 AM, Andreas Dilger wrote:
> On Feb 28, 2019, at 7:22 AM, Bob Liu <bob.liu@oracle.com> wrote:
>>
>> On 2/19/19 5:31 AM, Dave Chinner wrote:
>>> On Wed, Feb 13, 2019 at 05:50:35PM +0800, Bob Liu wrote:
>>>> Motivation:
>>>> When fs data/metadata checksum mismatch, lower block devices may have other
>>>> correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
>>>> decides that the metadata is garbage, today it will shut down the entire
>>>> filesystem without trying any of the other mirrors.  This is a severe
>>>> loss of service, and we propose these patches to have XFS try harder to
>>>> avoid failure.
>>>>
>>>> This patch prototype this mirror retry idea by:
>>>> * Adding @nr_mirrors to struct request_queue which is similar as
>>>>  blk_queue_nonrot(), filesystem can grab device request queue and check max
>>>>  mirrors this block device has.
>>>>  Helper functions were also added to get/set the nr_mirrors.
>>>>
>>>> * Introducing bi_rd_hint just like bi_write_hint, but bi_rd_hint is a long bitmap
>>>> in order to support stacked layer case.
>>>>
>>>> * Modify md/raid1 to support this retry feature.
>>>>
>>>> * Adapter xfs to use this feature.
>>>>  If the read verify fails, we loop over the available mirrors and retry the read.
>>>
>>> Why does the filesystem have to iterate every single posible
>>> combination of devices that are underneath it?
> 
> Even if the filesystem isn't doing this iteration, there needs to be
> some way to track which devices or combinations of devices have been
> tried for the bio, which likely still means something inside the bio.
> 
>>> Wouldn't it be much simpler to be able to attach a verifier
>>> function to the bio, and have each layer that gets called iterate
>>> over all it's copies internally until the verfier function passes
>>> or all copies are exhausted?
>>>
>>> This works for stacked mirrors - it can pass the higher layer
>>> verifier down as far as necessary. It can work for RAID5/6, too, by
>>> having that layer supply it's own verifier for reads that verifies
>>> parity and can reconstruct of failure, then when it's reconstructed
>>> a valid stripe it can run the verifier that was supplied to it from
>>> above, etc.
>>>
>>> i.e. I dont see why only filesystems should drive retries or have to
>>> be aware of the underlying storage stacking. ISTM that each
>>> layer of the storage stack should be able to verify what has been
>>> returned to it is valid independently of the higher layer
>>> requirements. The only difference from a caller point of view should
>>> be submit_bio(bio); vs submit_bio_verify(bio, verifier_cb_func);
> 
> I don't think the filesystem should be aware of the stacking (nor are
> they in the proposed implementation).  That said, the filesystem-level
> checksums should, IMHO, be checked at the filesystem level, and this
> proposal allows the filesystem to tell the lower layer "this read was
> bad, try something else".
> 
> One option, instead of having a bitmap, with one bit for every possible
> device/combination in the system, would be to have a counter instead.
> This is much denser, and even the existing "__u16 bio_write_hint" field

Indeed! This way is better than a bitmap.

But as Dave mentioned, it's much better and simpler if attaching a verfier function to the bio..

-
Thanks,
Bob

> would be enough for 2^16 different devices/combinations of devices to
> be tried.  The main difference would be that the retry layers in the
> device layer would need to have a deterministic iterator for the bio.
> 
> For stacked devices it would need to use the same API to determine how
> many possible combinations are below it, and do a modulus to pass down
> the per-device iteration number.  The easiest would be to iterate in
> numeric order, but it would also be possible to use something like a
> PRNG seeded by e.g. the block number to change the order on a per-bio
> basis to even out the load, if that is desirable.
> 
>> For a two layer stacked md case like:
>>                              /dev/md0
>>             /                  |                  \
>>      /dev/md1-a             /dev/md1-b          /dev/sdf
>>   /        \           /       |        \
>> /dev/sda /dev/sdb  /dev/sdc /dev/sdd  /dev/sde
> 
> In this case, the top-level md0 would call blk_queue_get_copies() on each
> sub-devices to determine how many sub-devices/combinations they have,
> and pick the maximum (3 in this case), multiplied by the number of
> top-level devices (also 3 in this case).  That means the top-level device
> would return blk_queue_get_copies() == 9 combinations, but the same
> could be done recursively for more/non-uniform layers if needed.
> 
> The top-level device maps md1-a = [0-2], md1-b = [3-5], md1-c = [6-8],
> and can easily map an incoming bio_read_hint to the next device, either
> by simple increment or by predetermining a device ordering and following
> that (e.g. 0, 3, 6, 1, 4, 7, 2, 5, 8), or any other deterministic order
> that hits all of the devices exactly once).  During submission bio_read_hint
> is set to the modulus of the value (so that each layer in the stack sees
> only values in the range [0, copies), and when the bio completes the top-level
> device will set bio_read_hint to be the next sub-device to try (like the
> original proposal was splitting and combining the bitmaps).  If a sub-device
> gets a bad index (e.g. md1-a sees bio_read_hint == 2, or sdf sees anything
> other than 0) it is a no-op and returns e.g. -EAGAIN to the upper device
> so that it moves to the next device without returning to the caller.
> 
>>> I suspect there's a more important issue to worry about: we run the
>>> XFS read verifiers in an async work queue context after collecting
>>> the IO completion status from the bio, rather than running directly
>>> in bio->bi_end_io() call chain.
> 
> In this proposal, XFS would just have to save the __u16 bio_read_hint
> field from the previous bio completion and set it in the retried bio,
> so that it could start at the next device/combination.  Obviously,
> this would mean that the internal device iterator couldn't have any
> hidden state for the bio so that just setting bio_read_hint would be
> the same as resubmitting the original bio again, but that is already
> a given or this whole problem wouldn't exist in the first place.
> 
> Cheers, Andreas
> 


