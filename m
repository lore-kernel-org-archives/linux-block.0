Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129ECC64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 15:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjB0Pjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjB0Pjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 10:39:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44C918AB5
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 07:39:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so27474601edb.9
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rJXB+iEam6DW138ELfP7qcmmpR4Y/Uxd0mnWuUGBS30=;
        b=QK2uT+9EbblWEV1f/7DsHEsS5gtxZBG7/6IeI5NzEyhRJHS8OfYacsvQzq/JTeQ9m9
         Ze9UUkQgx2b3SKq4WOcRLKZ8L03yoVs2k0CV4OsSihxCLcXbypv7uX29Ib0JVX/ekqQU
         1Uh6a4pYkCHeexzbuHkPuhArNDzWD28yatc60oZ/gV0a/NmQCdmB0ho30dmJnFQY+A/5
         foU0t3Oan12SF1dIDb03xbKLin7eg9yWGXmFdGwpUBAJgNN0aV2tHkJA+duGC+iqw/2X
         97q5Kf+A/Mrqzzi/6zRiu/lmhg2j7B9zZIaLZqTBcJw2bM6qzBCyXYNldqNuPRsbWjWU
         kEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJXB+iEam6DW138ELfP7qcmmpR4Y/Uxd0mnWuUGBS30=;
        b=bhYu7sNglPgA7k4XJZWNm+fLT4DMk+eFUlgdsBLXlyegKakcJB7Bf1D15fKqBukP0n
         iNeMlynYqWYBmv2TBTUHOWS9XcntMmUAHCN8wv08ww88SRGmhHrSUaFbTRA6whwOFc+t
         Z3zZCnO0Pb+YBtUSkDgbvDsU3wYFaZ4aR7+i58neiohkvnsL1NPCwaHDOvjA4JYhfa19
         HBBDOoFZyvB+jrGpIsed9UFpNPZfR3K1wF2XCwjcz2iAVsDEhsynvfNStuedttOD90iR
         7RFlQmdFy6gKIcJlobXaQlephOXVDDP333ZmimBwxwEOrGZgptC4Cd4OU7nfkNZqMkxd
         VYFw==
X-Gm-Message-State: AO0yUKWAi4jhXZepmuJVP9D/DY8YXWS0fPZ+APoWOveEFu2VauLC77kl
        sccKa8bzEZUMKgS1Sl8OHW/Sxw==
X-Google-Smtp-Source: AK7set/Gmh6PCn5iZtjvDOdCbd5sn0yjN5JRBObxoLJxNyLI85wyrGw/Kw3riG+LciljWDq6SM0RBw==
X-Received: by 2002:a17:906:d90:b0:7d3:c516:6ef4 with SMTP id m16-20020a1709060d9000b007d3c5166ef4mr33269330eji.20.1677512365237;
        Mon, 27 Feb 2023 07:39:25 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090619ce00b008f14cc5f2e4sm3357822ejd.68.2023.02.27.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:39:24 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <Y/zKQx6IRirQpoIf@minwoo-desktop>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Mon, 27 Feb 2023 16:36:15 +0100
In-reply-to: <Y/zKQx6IRirQpoIf@minwoo-desktop>
Message-ID: <87wn4386dw.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Minwoo Im <minwoo.im.dev@gmail.com> writes:

> On 23-02-24 21:05:01, Andreas Hindborg wrote:
>> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +			     unsigned int nr_zones, report_zones_cb cb,
>> +			     void *data)
>> +{
>> +	struct ublk_device *ub;
>> +	unsigned int zone_size;
>> +	unsigned int first_zone;
>> +	int ret = 0;
>> +
>> +	ub = disk->private_data;
>> +
>> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
>> +		return -EINVAL;
>> +
>> +	zone_size = disk->queue->limits.chunk_sectors;
>> +	first_zone = sector >> ilog2(zone_size);
>> +	nr_zones = min(ub->ub_disk->nr_zones - first_zone, nr_zones);
>> +
>> +	for (unsigned int i = 0; i < nr_zones; i++) {
>> +		struct request *req;
>> +		blk_status_t status;
>> +		struct blk_zone info = {0};
>> +
>> +		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
>> +
>> +		if (IS_ERR(req)) {
>> +			ret = PTR_ERR(req);
>> +			goto out;
>> +		}
>
> Can we just return directly just like above (-EINVAL)?
>
> if (IS_ERR(req))
> 	return PTR_ERR(req);

Yes, I agree.

>
>> +
>> +		req->__sector = sector;
>> +
>> +		ret = blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
>> +				      GFP_KERNEL);
>> +
>> +		if (ret)
>> +			goto out;
>
> If we really have to use goto here, then I think we have choices:
> put blk_mq_free_request(req); here or put it to the out: area.

Lets free here and drop the goto.

Thanks,
Andreas

>> +
>> +		status = blk_execute_rq(req, 0);
>> +		ret = blk_status_to_errno(status);
>> +		if (ret)
>> +			goto out;
>> +
>> +		blk_mq_free_request(req);
>> +
>> +		ret = cb(&info, i, data);
>> +		if (ret)
>> +			goto out;
>> +
>> +		/* A zero length zone means don't ask for more zones */
>> +		if (!info.len) {
>> +			nr_zones = i;
>> +			break;
>> +		}
>> +
>> +		sector += zone_size;
>> +	}
>> +	ret = nr_zones;
>> +
>> + out:
>> +	return ret;
>> +}

