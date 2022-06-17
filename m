Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E48C43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 06:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380234AbiFQG4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 02:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380098AbiFQG4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 02:56:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DA4EDF3
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655448972; x=1686984972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1h2b47a7yQ4psgtiKa1vXTHgS2gxDIb5ubjtosDpiqE=;
  b=k+Vt48OnvEp5CofEytC2DcRniZ4I4Tc1LttqCN9bXuZY1hH5EDGLWnb+
   mLdA4Swe8HYRCqF07RZHFrdPt9TLFBbVgzrveDmHPpludmwkPZxx67r/T
   JGA9JWdzZLA8T/z+XN2N9nXti+YCuErbYxRX576Ynmpd2Tc7d4Tg+PXnT
   e+IiyBgzdgZWZnWc8uW/WxfGg2EnqYyZOtjVkibejx4BGO6ZMQ9gBpaQ4
   h3QdcqRbLheYUkiX9oSvS44gd0R4WW2P6YyQxjtA4k0J0kHHTeQhyCgkI
   DkTOOB9BhgS6h79Po4yqhAk9cZHJ3hP+Ccw1lgbTtRKdpffIrdN5cvtAY
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204164975"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 14:56:10 +0800
IronPort-SDR: B4G83c1754Dn7O5RZSOrPgUQ5JStDBqVui2O0hq6PihuONIKhEZ1tBwXcBn3cgRyGdDawMcNbz
 lwZdUX74bpq4TaTZOg6wetw/J/z2pIR4uehqqtgIXNtQnOwOjbQ7S/xVHU75pL1FJltS+/uVvL
 Hf1VQBHNPGE2wi1EtQXy9A+ys0g3FfwZvyO+bQ559JNFo1g6BsngCNiFW00uf5OdVbJxECC/jV
 spQzfRJGfwoQ44/TwTfApjtFtq3EtZ23VFe5QgqJev948m3r4ZRccPScPv6T/y2M0Lfs1NbKeh
 C0zS6Ndh3RcHYVf10UWjtVg/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:14:21 -0700
IronPort-SDR: R4nJ06w/QInsux3yQJ7mU+J+krBS7yA7NswvYkqHmyLA8bCxcGlq6NqZzx1OgYrhhzAQDWUEXs
 /5oQA3XvA8cIndOZRjbx45EFP8ESWqqEmQ9diwkpbT8S6nBLEiJPkHunMCw4+PLs0mYZ6qfjmM
 te3FB7AuuLJvLzsSdAYUUA2W0d/UWjehFuV9T1mRaL/VjCL6+VwaQmeRULYF5cEVX9yRWoDjIX
 P8YH70x+7s/T/gfRfthNC23QfmwcNqsNHZV6rGhXRKK9qvdJ7bH7IVBRX+bP2DTIhvWuCua3u/
 xIk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:56:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPVF458F0z1SVp8
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 23:56:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655448967; x=1658040968; bh=1h2b47a7yQ4psgtiKa1vXTHgS2gxDIb5ubj
        tosDpiqE=; b=j1atsB5LvKvor6LNUEAg43gvXa37A3NJUa7sAfj9QCf/EYpfJHa
        J5oymJfQjtZy6XwtfcpxshMlV7cCp+t59qFyugVB4FLYtsbzJazW3KR/JD5OhMQk
        bHFAe3xxclVqFRUazTnSh9uZfU6EFYa2jUtNdDt9dJ4vgMNb91VutEARBWy4oTPS
        PA8Nl5n148hrOnVoOq8B8mwacDcbEAYTZOEcHsLNKeMwkjTajn5r26ZX5ihuMMf8
        Ve8K1OpbbfXvQFFpDQmvgOfBnPIgDmnK3iemnUw6x1c/vbdXs4tQk6986dYAorr0
        J8GoU5q8Q1JfRaj0M6RcV4IsmyO2rY03CqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nkeoOHwdZoiA for <linux-block@vger.kernel.org>;
        Thu, 16 Jun 2022 23:56:07 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPVF05H8mz1Rvlc;
        Thu, 16 Jun 2022 23:56:04 -0700 (PDT)
Message-ID: <f4cf6348-dd94-aa82-7519-318248c51151@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 15:56:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
 <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
 <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
 <0c4f30f2-c206-0201-31e3-fbb9edbdf666@opensource.wdc.com>
 <4746a000-2220-211e-1bd6-79c15c18a85c@samsung.com>
 <e0dc08fd-cd00-240d-edc4-5799d51aa5a8@opensource.wdc.com>
 <a945def3-ba5a-7539-e96a-43ade0ae674a@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a945def3-ba5a-7539-e96a-43ade0ae674a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/22 15:40, Pankaj Raghav wrote:
> On 2022-06-17 08:12, Damien Le Moal wrote:
>>> I think this is a cleaner approach using features flag and io_hints
>>> instead of messing with the revalidate zone function:
>>>
>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>> index 135c0cc190fb..c97a71e0473f 100644
>>> --- a/drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -1618,6 +1618,9 @@ static int device_not_matches_zone_sectors(struct
>>> dm_target *ti, struct dm_dev *
>>>  	if (!blk_queue_is_zoned(q))
>>>  		return 0;
>>>
>>> +	if(dm_target_supports_emulated_zone_size(ti->type))
>>> +		return 0;
>>> +
>>
>> This should be in validate_hardware_zoned_model(), not here.
>>
> I am not sure about this comment. We need to peek into the individual
> target from the table to check for this feature right?
> 
> if (dm_table_any_dev_attr(table, device_not_matches_zone_sectors,
> &zone_sectors)) {
> 	DMERR("%s: zone sectors is not consistent across all zoned devices",
>         dm_device_name(table->md));
> 	return -EINVAL;
> 	}
> 
> So we call this function device_not_matches_zone_sectors() from
> validate_hardware_zoned_model() for each target and we let the validate
> succeed even if the target's zone size is different from the underlying
> device zone size if this feature flag is set. Let me know if I am
> missing something and how this can be moved to
> validate_hardware_zoned_model().

Your change does not match the function name
device_not_matches_zone_sectors(), at all. So I think this is wrong.

The fact is that zone support in DM has been built under the following
assumptions:
1) A zoned device can be used to create a *zoned* target (e.g. dm-linear,
dm-flakey, dm-crypt). For this case, the target *must* use the same zone
size as the underlying devices and all devices used for the target must
have the same zone size.
2) A zoned device can be used to create a *regular* device target (e.g.
dm-zoned). All zoned devices used for the target must have the same zone size.

This new target driver completely breaks (1) and does not fit with (2). I
suspect this is why you are seeing problems with dm_revalidate_zones() as
that one uses the underlying device instead of the target report zones.

Based on this analysis, validate_hardware_zoned_model() definitely needs
to be changed. But device_not_matches_zone_sectors() is to check the
assumptions (1) and (2) so changing it for your new case is wrong in my
opinion. You need another set of assumptions (3) (define that well please)
and modify validate_hardware_zoned_model() so that the defined constraints
are checked. Using a target flag to indicate the type of zoned target is
fine by me.

-- 
Damien Le Moal
Western Digital Research
