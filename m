Return-Path: <SRS0=Q27d=RG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88118C43381
	for <linux-block@archiver.kernel.org>; Sun,  3 Mar 2019 02:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DFD20815
	for <linux-block@archiver.kernel.org>; Sun,  3 Mar 2019 02:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L9KnIZTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfCCCjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Mar 2019 21:39:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCCCjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Mar 2019 21:39:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x232Y9mc170532;
        Sun, 3 Mar 2019 02:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XrI9aYIrbSqWg8UjpDWkeeI74dPYPS3W/OlRhMJbEKI=;
 b=L9KnIZTIxvbG9+rAxqsYQTi5zzZ2NFmBqkGKuV6JF9Lb2FXh2pOWKi/RZSqe4dZCEKSK
 0BUfodfex8kSigrbMxnSPSATFPV7hhQmtBWaGMQBAsNnDS34TrH1un9JnRTuxLhjGKyv
 4zEA0UW/OAWpBoywDHI/TYvZgZiObVO7XgKOcnZsRIeuuCSDvcK/dPFWu/w4Mo47FLlT
 ywldctxE1xNJr28YT1ajBYpwFVq3C0GBDzNNy+1kBmDpTPksV2XNBS6fVQdxHb8T4MY/
 PIAd9lPezIUpk6ZxmOxlETBu+yoAu+8wFqOnYJosEoKR+IhnloEEEpl4DY4et714+rpU VQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qyjfr25qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Mar 2019 02:38:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x232c3Pd013100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Mar 2019 02:38:03 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x232c2JO031698;
        Sun, 3 Mar 2019 02:38:03 GMT
Received: from [192.168.1.12] (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 02 Mar 2019 18:38:02 -0800
Subject: Re: [RFC PATCH v2 0/9] Block/XFS: Support alternative mirror device
 retry
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, martin.petersen@oracle.com,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190218213150.GE14116@dastard>
 <ba78a587-04ba-58a4-f282-63e200c81e2d@oracle.com>
 <20190228214949.GO23020@dastard>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <4c930f97-31cd-cbd9-effb-db3090e0f273@oracle.com>
Date:   Sun, 3 Mar 2019 10:37:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190228214949.GO23020@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9183 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903030019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/19 5:49 AM, Dave Chinner wrote:
> On Thu, Feb 28, 2019 at 10:22:02PM +0800, Bob Liu wrote:
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
>>>>   blk_queue_nonrot(), filesystem can grab device request queue and check max
>>>>   mirrors this block device has.
>>>>   Helper functions were also added to get/set the nr_mirrors.
>>>>
>>>> * Introducing bi_rd_hint just like bi_write_hint, but bi_rd_hint is a long bitmap
>>>> in order to support stacked layer case.
>>>>
>>>> * Modify md/raid1 to support this retry feature.
>>>>
>>>> * Adapter xfs to use this feature.
>>>>   If the read verify fails, we loop over the available mirrors and retry the read.
>>>
>>> Why does the filesystem have to iterate every single posible
>>> combination of devices that are underneath it?
>>>
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
>>>
>>
>> We already have bio->bi_end_io(), how about do the verification inside bi_end_io()?
>>
>> Then the whole sequence would like:
>> bio_endio()
>>     > 1.bio->bi_end_io()
>>         > xfs_buf_bio_end_io()
>>             > verify, set bio->bi_status = "please retry" if verify fail
>>         
>>     > 2.if found bio->bi_status = retry
>>     > 3.resubmit bio
> 
> As I mentioned to Darrick, this isn't cwas simple as it seems
> because what XFS actually does is this:
> 
> IO completion thread			Workqueue Thread
> bio_endio(bio)
>   bio->bi_end_io(bio)
>     xfs_buf_bio_end_io(bio)
>       bp->b_error = bio->bi_status
>       xfs_buf_ioend_async(bp)
>         queue_work(bp->b_ioend_wq, bp)
>       bio_put(bio)
> <io completion done>
> 					.....
> 					xfs_buf_ioend(bp)
> 					  bp->b_ops->read_verify()
> 					.....
> 
> IOWs, XFS does not do read verification inside the bio completion
> context, but instead defers it to an external workqueue so it does
> not delay processing incoming bio IO completions. Hence there is no
> way to get the verification status back to the bio completion (the
> bio has already been freed!) to resubmit from there.
> 
> This is one of the reasons I suggested a verifier be added to the
> submission, so the bio itself is wholly responsible for running it,

But then completion time of an i/o would be longer if calling verifier function inside bio_endio().
Would that be a problem? Since it used to be async as your mentioned xfs uses workqueue.

Thanks, -Bob


> not an external, filesystem level completion function that may
> operate outside of bio scope....
> 
>> Is it fine to resubmit a bio inside bio_endio()?
> 
> Depends on the context the bio_endio() completion is running in.
> 
