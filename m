Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 23:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiDLXpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiDLXpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 19:45:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701711177
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649806309; x=1681342309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=/OZapqEAwvC33AYXsoDR6Phx2aqKTlYIMskcR01mxQM=;
  b=k23419BlwJfP6tcoRjz1faOTNqZw4WG4pVGNO3bgkSrhlyq5YVfLWmX0
   Zequ3Y3cPwiISoADcKHQ1MrMeJhbXg35UFFWX00af3RRCjcD8acFjZNRR
   L/3Wjub0etd+MCFiY73zqjg7Svw+/P72IhSuIH91jue4716fsWurbChTn
   tY/XE1eMCRn//o9evnHlvRe50nuDHDs8xDLYxa4MSzda/USfDRHIObMQW
   NddLA3EA8/QHJhRfqKnf6FghLZAO24NsDi3sTWDOl/n/wkMUInaZUpwwQ
   E0UUlpli+Eu2so1WyLIWthurlU6nPUEBdZztrYxk1uS7aThpJp4KTPpPk
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,254,1643644800"; 
   d="sh'?scan'208";a="196638048"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 07:31:48 +0800
IronPort-SDR: 1f2XVrEbhGh1ZWpxwFu2Hd4eheUhyeQrhDNF/Ag1Et92pElZiS3ZI5uJLRvs6OCVuGS8MtOXcz
 2hAnwV0+XWHw8OegYoB5b1oq6hm218DelLI/5yos/Yeg5X3dJHqShKCnGWyRjOASZSahAQ3Xxh
 qBDtEIaP+7Ma963IzhuMdzO5IpycGFuI1KlFJfA+ItDTXD1VejZTBBfmHnkEZtIGBdXjyWEf5R
 jhxipSAcbUYcINNNUD6TL3WUizi3p8lrozu4IxB/hajLmsEbpzKdvS7D5J6oKPsPePrTImuOzI
 dMKxCE0S4ZzJq6BWVIqjVHnZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 16:02:16 -0700
IronPort-SDR: i8MBCefsSVNjkKmDMfzIoCYIillCx1qCH5sF940oP7OTLR/AtoOXI/xvnasc1RZGso/GjdQsQP
 rFRHpvL6PlVZYYS/APcG86dGLyHZwi1kn805zrdiWxtGw/L/NVNRRTSsb2eGmXJLBZQ0MyGpKL
 zYA1vOnkeWhiNOpBav2l7tpFsPUQPHBMkCWak8SG0dhBvspka4yGKk8O5eKqp0a2QbXTlXK9UG
 vR/ka709lHBll7UM1bIbTE9fVq9d0ezhNaoPUo6cE4IH1jKqN8kaOGFLsr4ZBsLoOVszFPOZUL
 pX8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 16:31:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KdMSN1QRSz1SVny
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 16:31:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=in-reply-to:organization:from:references
        :to:content-language:subject:user-agent:mime-version:date
        :message-id:content-type; s=dkim; t=1649806307; x=1652398308;
         bh=/OZapqEAwvC33AYXsoDR6Phx2aqKTlYIMskcR01mxQM=; b=Om1fEBXazDcc
        Bh2R/ePGTPg2xld01Entfig3BN6ffcd6CrISDOCQaJUJm8ptGM5PNd5SIxTqd5KY
        6dDsofDspzGNCC0MdlU3g9XgZupwtp/XME+y/dZ0J4O2UxV+eLcUKjXWr39HMbLJ
        CPh6pGCpVz68lGih+nyFndrD3Xx8ThbwjEkf68Uo1LN9+C0MvdVFYiGxJX2LAePg
        5eZpyBkmBaoNAYiwzEfsPLcz6D+f9jWCNwo4uuiX1LS+6iXkn2sEu3IIh70a7Ty4
        Uo36qXttrXktlPFkLYZH0nhMfk1uisa6YANqPzb5z1c62KR+FoE0KDlwZIClX4Y3
        Bgp/QpMj9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cGyN215Kz_gL for <linux-block@vger.kernel.org>;
        Tue, 12 Apr 2022 16:31:47 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KdMSL1G1mz1Rvlx;
        Tue, 12 Apr 2022 16:31:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------egsgRdPfyYMP0pfbru57ULgc"
Message-ID: <44a6c5cd-d9ca-e238-4574-73d9140a0d8d@opensource.wdc.com>
Date:   Wed, 13 Apr 2022 08:31:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com> <YlXmmB6IO7usz2c1@redhat.com>
 <c4c83c0f-a4fc-2b37-180f-ccb272085fca@opensource.wdc.com>
 <YlYEq0XC2XL6bv2b@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YlYEq0XC2XL6bv2b@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------egsgRdPfyYMP0pfbru57ULgc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/22 08:00, Mike Snitzer wrote:
> On Tue, Apr 12 2022 at  6:38P -0400,
> Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 4/13/22 05:52, Mike Snitzer wrote:
>>> On Tue, Apr 12 2022 at  4:56P -0400,
>>> Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>>> The current DM codes setup ->orig_bio after __map_bio() returns,
>>>> and not only cause kernel panic for dm zone, but also a bit ugly
>>>> and tricky, especially the waiting until ->orig_bio is set in
>>>> dm_submit_bio_remap().
>>>>
>>>> The reason is that one new bio is cloned from original FS bio to
>>>> represent the mapped part, which just serves io accounting.
>>>>
>>>> Now we have switched to bdev based io accounting interface, and we
>>>> can retrieve sectors/bio_op from both the real original bio and the
>>>> added fields of .sector_offset & .sectors easily, so the new cloned
>>>> bio isn't necessary any more.
>>>>
>>>> Not only fixes dm-zone's kernel panic, but also cleans up dm io
>>>> accounting & split a bit.
>>>
>>> You're conflating quite a few things here.  DM zone really has no
>>> business accessing io->orig_bio (dm-zone.c can just as easily inspect
>>> the tio->clone, because it hasn't been remapped yet it reflects the
>>> io->origin_bio, so there is no need to look at io->orig_bio) -- but
>>> yes I clearly broke things during the 5.18 merge and it needs fixing
>>> ASAP.
>>
>> Problem is that we need to look at the BIO op in submission AND completion
>> path to handle zone append requests. So looking at the clone on submission
>> is OK since its op is still the original one. But on the completion path,
>> the clone may now be a regular write emulating a zone append op. And
>> looking at the clone only does not allow detecting that zone append.
>>
>> We could have the orig_bio op saved in dm_io to avoid completely looking
>> at the orig_bio for detecting zone append.
> 
> Can you please try the following patch?

OK. Will do right away.

> 
> Really sorry for breaking dm-zone.c; please teach this man how to test
> the basics of all things dm-zoned (is there a testsuite in the tools
> or something?).

We have an internal test suite to check all things related to zone. We run
that weekly on all RC releases. We did not catch the problem earlier as we
do not run against for-next trees in previous cycles. We could add such
runs :)

We would be happy to contribute stuff for testing. Ideally, integrating
that into blktest, with a new DM group, would be nice. That was discussed
in past LSF. Maybe a topic again for this year ? Beside zone stuff, I am
sure we can add more DM tests (I am sure you do also have a test suite ?).

For quick tests, I generally use a zoned nullblk device. I am attaching 2
scripts which allow creating and deleting nullblk devices easily.

> 
> Thanks,
> Mike
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index c1ca9be4b79e..896127366000 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -360,16 +360,20 @@ static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
>  	return 0;
>  }
>  
> +struct orig_bio_details {
> +	unsigned int op;
> +	unsigned int nr_sectors;
> +};
> +
>  /*
>   * First phase of BIO mapping for targets with zone append emulation:
>   * check all BIO that change a zone writer pointer and change zone
>   * append operations into regular write operations.
>   */
> -static bool dm_zone_map_bio_begin(struct mapped_device *md,
> -				  struct bio *orig_bio, struct bio *clone)
> +static bool dm_zone_map_bio_begin(struct mapped_device *md, unsigned int zno,
> +				  struct bio *clone)
>  {
>  	sector_t zsectors = blk_queue_zone_sectors(md->queue);
> -	unsigned int zno = bio_zone_no(orig_bio);
>  	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
>  
>  	/*
> @@ -384,7 +388,7 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  		WRITE_ONCE(md->zwp_offset[zno], zwp_offset);
>  	}
>  
> -	switch (bio_op(orig_bio)) {
> +	switch (bio_op(clone)) {
>  	case REQ_OP_ZONE_RESET:
>  	case REQ_OP_ZONE_FINISH:
>  		return true;
> @@ -401,9 +405,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  		 * target zone.
>  		 */
>  		clone->bi_opf = REQ_OP_WRITE | REQ_NOMERGE |
> -			(orig_bio->bi_opf & (~REQ_OP_MASK));
> -		clone->bi_iter.bi_sector =
> -			orig_bio->bi_iter.bi_sector + zwp_offset;
> +			(clone->bi_opf & (~REQ_OP_MASK));
> +		clone->bi_iter.bi_sector += zwp_offset;
>  		break;
>  	default:
>  		DMWARN_LIMIT("Invalid BIO operation");
> @@ -423,11 +426,10 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>   * data written to a zone. Note that at this point, the remapped clone BIO
>   * may already have completed, so we do not touch it.
>   */
> -static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
> -					struct bio *orig_bio,
> +static blk_status_t dm_zone_map_bio_end(struct mapped_device *md, unsigned int zno,
> +					struct orig_bio_details *orig_bio_details,
>  					unsigned int nr_sectors)
>  {
> -	unsigned int zno = bio_zone_no(orig_bio);
>  	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
>  
>  	/* The clone BIO may already have been completed and failed */
> @@ -435,7 +437,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
>  		return BLK_STS_IOERR;
>  
>  	/* Update the zone wp offset */
> -	switch (bio_op(orig_bio)) {
> +	switch (orig_bio_details->op) {
>  	case REQ_OP_ZONE_RESET:
>  		WRITE_ONCE(md->zwp_offset[zno], 0);
>  		return BLK_STS_OK;
> @@ -452,7 +454,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
>  		 * Check that the target did not truncate the write operation
>  		 * emulating a zone append.
>  		 */
> -		if (nr_sectors != bio_sectors(orig_bio)) {
> +		if (nr_sectors != orig_bio_details->nr_sectors) {
>  			DMWARN_LIMIT("Truncated write for zone append");
>  			return BLK_STS_IOERR;
>  		}
> @@ -488,7 +490,7 @@ static inline void dm_zone_unlock(struct request_queue *q,
>  	bio_clear_flag(clone, BIO_ZONE_WRITE_LOCKED);
>  }
>  
> -static bool dm_need_zone_wp_tracking(struct bio *orig_bio)
> +static bool dm_need_zone_wp_tracking(struct bio *clone)
>  {
>  	/*
>  	 * Special processing is not needed for operations that do not need the
> @@ -496,15 +498,15 @@ static bool dm_need_zone_wp_tracking(struct bio *orig_bio)
>  	 * zones and all operations that do not modify directly a sequential
>  	 * zone write pointer.
>  	 */
> -	if (op_is_flush(orig_bio->bi_opf) && !bio_sectors(orig_bio))
> +	if (op_is_flush(clone->bi_opf) && !bio_sectors(clone))
>  		return false;
> -	switch (bio_op(orig_bio)) {
> +	switch (bio_op(clone)) {
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
>  	case REQ_OP_ZONE_RESET:
>  	case REQ_OP_ZONE_FINISH:
>  	case REQ_OP_ZONE_APPEND:
> -		return bio_zone_is_seq(orig_bio);
> +		return bio_zone_is_seq(clone);
>  	default:
>  		return false;
>  	}
> @@ -519,8 +521,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  	struct dm_target *ti = tio->ti;
>  	struct mapped_device *md = io->md;
>  	struct request_queue *q = md->queue;
> -	struct bio *orig_bio = io->orig_bio;
>  	struct bio *clone = &tio->clone;
> +	struct orig_bio_details orig_bio_details;
>  	unsigned int zno;
>  	blk_status_t sts;
>  	int r;
> @@ -529,18 +531,21 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  	 * IOs that do not change a zone write pointer do not need
>  	 * any additional special processing.
>  	 */
> -	if (!dm_need_zone_wp_tracking(orig_bio))
> +	if (!dm_need_zone_wp_tracking(clone))
>  		return ti->type->map(ti, clone);
>  
>  	/* Lock the target zone */
> -	zno = bio_zone_no(orig_bio);
> +	zno = bio_zone_no(clone);
>  	dm_zone_lock(q, zno, clone);
>  
> +	orig_bio_details.nr_sectors = bio_sectors(clone);
> +	orig_bio_details.op = bio_op(clone);
> +
>  	/*
>  	 * Check that the bio and the target zone write pointer offset are
>  	 * both valid, and if the bio is a zone append, remap it to a write.
>  	 */
> -	if (!dm_zone_map_bio_begin(md, orig_bio, clone)) {
> +	if (!dm_zone_map_bio_begin(md, zno, clone)) {
>  		dm_zone_unlock(q, zno, clone);
>  		return DM_MAPIO_KILL;
>  	}
> @@ -560,7 +565,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  		 * The target submitted the clone BIO. The target zone will
>  		 * be unlocked on completion of the clone.
>  		 */
> -		sts = dm_zone_map_bio_end(md, orig_bio, *tio->len_ptr);
> +		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
> +					  *tio->len_ptr);
>  		break;
>  	case DM_MAPIO_REMAPPED:
>  		/*
> @@ -568,7 +574,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  		 * unlock the target zone here as the clone will not be
>  		 * submitted.
>  		 */
> -		sts = dm_zone_map_bio_end(md, orig_bio, *tio->len_ptr);
> +		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
> +					  *tio->len_ptr);
>  		if (sts != BLK_STS_OK)
>  			dm_zone_unlock(q, zno, clone);
>  		break;
> 


-- 
Damien Le Moal
Western Digital Research
--------------egsgRdPfyYMP0pfbru57ULgc
Content-Type: application/x-shellscript; name="nullblk-create.sh"
Content-Disposition: attachment; filename="nullblk-create.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNjcmlwdGRpcj0iJChjZCAiJChkaXJuYW1lICIkMCIpIiAmJiBwd2Qp
IgoKZnVuY3Rpb24gdXNhZ2UoKQp7CgllY2hvICJVc2FnZTogJChiYXNlbmFtZSAkMCkgW29w
dGlvbnNdIgoJZWNobyAiT3B0aW9uczoiCgllY2hvICIgICAgLWggfCAtLWhlbHAgICAgICA6
IERpc3BsYXkgdGhpcyBoZWxwIG1lc3NhZ2UgYW5kIGV4aXQiCgllY2hvICIgICAgLXYgICAg
ICAgICAgICAgICA6IEJlIHZlcmJvc2UgKGRpc3BsYXkgZmluYWwgY29uZmlnKSIKCWVjaG8g
IiAgICAtY2FwIDxzaXplIChHQik+IDogc2V0IGRldmljZSBjYXBhY2l0eSAoZGVmYXVsdDog
OCkiCgllY2hvICIgICAgICAgICAgICAgICAgICAgICAgIEZvciB6b25lZCBkZXZpY2VzLCBj
YXBhY2l0eSBpcyBkZXRlcm1pbmVkIgoJZWNobyAiICAgICAgICAgICAgICAgICAgICAgICB3
aXRoIHpvbmUgc2l6ZSBhbmQgdG90YWwgbnVtYmVyIG9mIHpvbmVzIgoJZWNobyAiICAgIC1i
cyA8c2l6ZSAoQik+ICAgOiBzZXQgc2VjdG9yIHNpemUgKGRlZmF1bHQ6IDUxMikiCgllY2hv
ICIgICAgLW0gICAgICAgICAgICAgICA6IGVuYWJsZSBtZW1vcnkgYmFja2luZyAoZGVmYXVs
dDogZmFsc2UpIgoJZWNobyAiICAgIC16ICAgICAgICAgICAgICAgOiBjcmVhdGUgYSB6b25l
ZCBkZXZpY2UgKGRlZmF1bHQ6IGZhbHNlKSIKCWVjaG8gIiAgICAtcW0gPG1vZGU+ICAgICAg
IDogc2V0IHF1ZXVlIG1vZGUgKGRlZmF1bHQ6IDIpIgoJZWNobyAiICAgICAgICAgICAgICAg
ICAgICAgICAwPWJpbywgMT1ycSwgMj1tdWx0aXF1ZXVlIgoJZWNobyAiICAgIC1zcSA8bnVt
PiAgICAgICAgOiBzZXQgbnVtYmVyIG9mIHN1Ym1pc3Npb24gcXVldWVzIgoJZWNobyAiICAg
ICAgICAgICAgICAgICAgICAgICAoZGVmYXVsdDogbnByb2MpIgoJZWNobyAiICAgIC1xZCA8
ZGVwdGg+ICAgICAgOiBzZXQgcXVldWUgZGVwdGggKGRlZmF1bHQ6IDY0KSIKCWVjaG8gIiAg
ICAtaW0gPG1vZGU+ICAgICAgIDogc2V0IElSUSBtb2RlIChkZWZhdWx0OiAwKSIKCWVjaG8g
IiAgICAgICAgICAgICAgICAgICAgICAgMD1ub25lLCAxPXNvZnRpcnEsIDI9dGltZXIiCgll
Y2hvICIgICAgLWMgPG5zZWNzPiAgICAgICA6IHNldCBjb21wbGV0aW9uIHRpbWUgZm9yIHRp
bWVyIGNvbXBsZXRpb24iCgllY2hvICIgICAgICAgICAgICAgICAgICAgICAgIChkZWZhdWx0
OiAxMDAwMCBucykiCgllY2hvICJPcHRpb25zIGZvciB6b25lZCBkZXZpY2VzOiIKCWVjaG8g
IiAgICAtenMgPHNpemUgKE1CKT4gIDogc2V0IHpvbmUgc2l6ZSAoZGVmYXVsdDogOCBNQiki
CgllY2hvICIgICAgLXpjIDxzaXplIChNQik+ICA6IHNldCB6b25lIGNhcGFjaXR5IChkZWZh
dWx0OiB6b25lIHNpemUpIgoJZWNobyAiICAgIC16bmMgPG51bT4gICAgICAgOiBzZXQgbnVt
YmVyIG9mIGNvbnYgem9uZXMgKGRlZmF1bHQ6IDApIgoJZWNobyAiICAgIC16bnMgPG51bT4g
ICAgICAgOiBzZXQgbnVtYmVyIG9mIHN3ciB6b25lcyAoZGVmYXVsdDogOCkiCgllY2hvICIg
ICAgLXpyICAgICAgICAgICAgICA6IGFkZCBhIHNtYWxsZXIgcnVudCBzd3Igem9uZSAoZGVm
YXVsdDogbm9uZSkiCgllY2hvICIgICAgLXptbyA8bnVtPiAgICAgICA6IHNldCBtYXggb3Bl
biB6b25lcyAoZGVmYXVsdDogbm8gbGltaXQpIgoJZWNobyAiICAgIC16bWEgPG51bT4gICAg
ICAgOiBzZXQgbWF4IGFjdGl2ZSB6b25lcyAoZGVmYXVsdDogbm8gbGltaXQpIgoKCWV4aXQg
MAp9CgpmdW5jdGlvbiBnZXRfbnVsbGJfaWQoKQp7Cglsb2NhbCBuaWQ9MAoKCXdoaWxlIFsg
MSBdOyBkbwoJCWlmIFsgISAtYiAiL2Rldi9udWxsYiR7bmlkfSIgXTsgdGhlbgoJCQlicmVh
awoJCWZpCgkJbmlkPSQoKCBuaWQgKyAxICkpCglkb25lCgoJZWNobyAiJG5pZCIKfQoKIyBT
ZXQgY29uZmlnIGRlZmF1bHRzCmNhcD04CmJzPTUxMgptPTAKcW09MgpzcT0kKG5wcm9jKQpx
ZD02NAppbT0wCmM9MTAwMDAKCno9MAp6cz04CnpjPTAKem5jPTAKem5zPTgKenI9MAp6bW89
MAp6bWE9MAoKdj0wCgojIFBhcnNlIGNvbW1hbmQgbGluZQp3aGlsZSBbWyAkIyAtZ3QgMCBd
XTsgZG8KCWNhc2UgIiQxIiBpbgoJIi1oIiB8ICItLWhlbHAiKQoJCXVzYWdlICIkMCIgOzsK
CSItdiIpCgkJdj0xIDs7CgkiLWNhcCIpCgkJc2hpZnQ7IGNhcD0kMSA7OwoJIi1icyIpCgkJ
c2hpZnQ7IGJzPSQxIDs7CgkiLW0iKQoJCW09MSA7OwoJIi1xbSIpCgkJc2hpZnQ7IHFtPSQx
IDs7CgkiLXNxIikKCQlzaGlmdDsgc3E9JDEgOzsKCSItcWQiKQoJCXNoaWZ0OyBxZD0kMSA7
OwoJIi1pbSIpCgkJc2hpZnQ7IGltPSQxIDs7CgkiLWMiKQoJCXNoaWZ0OyBjPSQxIDs7Cgki
LXoiKQoJCXo9MSA7OwoJIi16cyIpCgkJc2hpZnQ7IHpzPSQxIDs7CgkiLXpjIikKCQlzaGlm
dDsgemM9JDEgOzsKCSItem5jIikKCQlzaGlmdDsgem5jPSQxIDs7CgkiLXpucyIpCgkJc2hp
ZnQ7IHpucz0kMSA7OwoJIi16ciIpCgkJenI9MSA7OwoJIi16bW8iKQoJCXNoaWZ0OyB6bW89
JDEgOzsKCSItem1hIikKCQlzaGlmdDsgem1hPSQxIDs7CgkqKQoJCWVjaG8gIkludmFsaWQg
b3B0aW9uIFwiJDFcIiAodXNlIC1oIG9wdGlvbiBmb3IgaGVscCkiCgkJZXhpdCAxIDs7Cgll
c2FjCgoJc2hpZnQKZG9uZQoKIyBDYWxjdWxhdGUgem9uZWQgZGV2aWNlIGNhcGFjaXR5Cmlm
IFsgJHogPT0gMSBdOyB0aGVuCgljYXA9JCgoIHpzICogKHpuYyArIHpucykgKSkKCWlmIFsg
JHpyID09IDEgXTsgdGhlbgoJCWNhcD0kKCggZ2IgKyB6bnMgLSAxICkpCglmaQplbHNlCglj
YXA9JCgoIGNhcCAqIDEwMjQgKSkKZmkKCiMgQ3JlYXRlIGRldmljZSBjb25maWcKbW9kcHJv
YmUgbnVsbF9ibGsgbnJfZGV2aWNlcz0wIHx8IHJldHVybiAkPwpuaWQ9JChnZXRfbnVsbGJf
aWQpCmRldj0iL3N5cy9rZXJuZWwvY29uZmlnL251bGxiL251bGxiJHtuaWR9Igpta2RpciAi
JHtkZXZ9IgoKZWNobyAkY2FwID4gIiR7ZGV2fSIvc2l6ZQplY2hvICRicyA+ICIke2Rldn0i
L2Jsb2Nrc2l6ZQplY2hvICRtID4gIiR7ZGV2fSIvbWVtb3J5X2JhY2tlZAplY2hvICRxbSA+
ICIke2Rldn0iL3F1ZXVlX21vZGUKZWNobyAkc3EgPiAiJHtkZXZ9Ii9zdWJtaXRfcXVldWVz
CmVjaG8gJHFkID4gIiR7ZGV2fSIvaHdfcXVldWVfZGVwdGgKZWNobyAkaW0gPiAiJHtkZXZ9
Ii9pcnFtb2RlCmlmIFsgJGltID09IDIgXTsgdGhlbgoJZWNobyAkYyA+ICIke2Rldn0iL2Nv
bXBsZXRpb25fbnNlYwpmaQoKZWNobyAkeiA+ICIke2Rldn0iL3pvbmVkCmlmIFsgJHogPT0g
MSBdOyB0aGVuCgllY2hvICR6cyA+ICIke2Rldn0iL3pvbmVfc2l6ZQoJZWNobyAkemMgPiAi
JHtkZXZ9Ii96b25lX2NhcGFjaXR5CgllY2hvICR6bmMgPiAiJHtkZXZ9Ii96b25lX25yX2Nv
bnYKCWVjaG8gJHptbyA+ICIke2Rldn0iL3pvbmVfbWF4X29wZW4KCWVjaG8gJHptYSA+ICIk
e2Rldn0iL3pvbmVfbWF4X2FjdGl2ZQpmaQoKIyBFbmFibGUgZGV2aWNlCmVjaG8gMSA+ICIk
e2Rldn0iL3Bvd2VyCmVjaG8gIkNyZWF0ZWQgL2Rldi9udWxsYiR7bmlkfSIKCmlmIFsgJHYg
PT0gMSBdOyB0aGVuCgllY2hvICJEZXZpY2UgY29uZmlndXJhdGlvbjoiCglncmVwIC1yIC4g
JHtkZXZ9CmZpCg==
--------------egsgRdPfyYMP0pfbru57ULgc
Content-Type: application/x-shellscript; name="nullblk-destroy.sh"
Content-Disposition: attachment; filename="nullblk-destroy.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCmlmIFsgJCMgIT0gMSBdOyB0aGVuCgllY2hvICJVc2FnZTogJChiYXNl
bmFtZSAkMCkgPG51bGxiIElEPiIKCWV4aXQgMQpmaQoKbmlkPSQxCgppZiBbICEgLWIgIi9k
ZXYvbnVsbGIkbmlkIiBdOyB0aGVuCgllY2hvICIvZGV2L251bGxiJG5pZDogTm8gc3VjaCBk
ZXZpY2UiCglleGl0IDEKZmkKCmVjaG8gMCA+IC9zeXMva2VybmVsL2NvbmZpZy9udWxsYi9u
dWxsYiRuaWQvcG93ZXIKcm1kaXIgL3N5cy9rZXJuZWwvY29uZmlnL251bGxiL251bGxiJG5p
ZAoKZWNobyAiRGVzdHJveWVkIC9kZXYvbnVsbGIkbmlkIgoK

--------------egsgRdPfyYMP0pfbru57ULgc--
