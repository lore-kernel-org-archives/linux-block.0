Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BEC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 22:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCQWj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCQWjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 18:39:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7226B32B
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679092763; x=1710628763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QqCVcd1o9+X40P1EwMH7YX1nBg8rtjGpkstT/tarGGs=;
  b=RyFG7Im0/3TzXduJbqmNJ3d89d6jLIUbsBLuE2ixDwJbQuISq+xiQEff
   RmFA/guOxPh2K58Mg8e+vEWOxDKsautnwMArerHmuKwBcainrfBGjLnZ6
   UcIf9ub7XkNWi5hT+zoLyiFrLZI/ts3Iw7u1ZndRCl21qMImucT/TzXqN
   6712NcZgNg+rZpXmueLyVLNRgX0bA+HmxzzQxHKZ+Pv6O3hL+gBDalJaK
   MU0uWqwsDo9AFT3xXisd8ncZKr6BQHJxA9oKajzXX1g81Lrd8Liy0uZK/
   CBjbPEqSUYwail9wcd7jDh6g4BrqiS1nomQptpDZOq+QF8rVcArmHrarj
   g==;
X-IronPort-AV: E=Sophos;i="5.98,270,1673884800"; 
   d="scan'208";a="224182116"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2023 06:39:22 +0800
IronPort-SDR: kebgIj+G5ZF/QvZWERtH5lXgG3rNApvhG2PCLZyc141j7a2CBVf8c0msHMNZ16/tEAd6ueE2JO
 Hy+y7qgQcTw0JIX7hdPP0c97v1580kZlJFo/D/X7r80yuygCvreN1+F/KoXjPJM6qFv7kDO5TG
 HSZASqyJZZsNBqyuzkSFMD0+lyEKSFBkhHlal115sXr3kSY2irqNwKXJi4ZfqcncXl6nxGZFCa
 qrYAFSXClqt2W2DLmu0cfTKuV2TNYhd7bZaM5letY96Dcno3BGRA8DPYs+2K0iaVkq5v3MNAVA
 Nwg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2023 14:50:05 -0700
IronPort-SDR: YvNvMnudN4fM0eaa4rQK8fyvMoHzaivWQzi1mbh/OgFrSwSp+EyLrHoXRUJ0ev/98wfFuE3IxX
 LsHE9Q23G4bPo60V/uwYwi0DPR+jmgQy1BTLaZbBEcs3tfO9c9V1+MpGDzy3HyO7Urm8v6AhPf
 KektRIfQMu1hlBwioP/DU2VamFXrsXA5qvs9kVCMru80MoXUEkU6OAPo7UzdYIDHd435hQ5xkY
 nx9aGCMFI0wzrgQogFdefwcNRPJEhqEooBZNZATlYcWo46hkq7OvRcpp3VvOosDgGR+ht/tYjn
 PxQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2023 15:39:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PdfFQ4TnVz1RtVy
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 15:39:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679092762; x=1681684763; bh=QqCVcd1o9+X40P1EwMH7YX1nBg8rtjGpkst
        T/tarGGs=; b=fgMU4ucD76nNXDM8aY+kSGjuqk8smKU77r3xAVGWSRPMXwjX1q7
        OIRLVXTmCt4H9AgszEdNlF9wWKaGzcDbNopXS7gzYl39o46+ovJOhcWZ7ucinxB7
        Bl3ZfhWGRy6VYXitHlToWE/mlX9o9ia6EUKyHNBH6lq0nQRX5SYKPaHU2BvF00rI
        lBndH9PMC4Xn2P59X7mQf3714hE+hoZ0FvCN2WogGcbSdAtidBpzguCUFeTH3Ghi
        ndDeAhhSEp2bE1U9tTeh8rm1gwsbkuBrLWsPDwyfWeW9aT1POlMWEmtlg/DTcN+d
        yj7o1DcVQzLlfROeT9/8M2xbfPpabpQMTHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KdjP7KZ4lg1e for <linux-block@vger.kernel.org>;
        Fri, 17 Mar 2023 15:39:22 -0700 (PDT)
Received: from [10.225.163.88] (unknown [10.225.163.88])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PdfFN55Q3z1RtVm;
        Fri, 17 Mar 2023 15:39:20 -0700 (PDT)
Message-ID: <9987139a-f423-3d2e-5abd-877b3d147134@opensource.wdc.com>
Date:   Sat, 18 Mar 2023 07:39:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] block: Support splitting REQ_OP_ZONE_APPEND bios
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
References: <20230317195036.1743712-1-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230317195036.1743712-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/23 04:50, Bart Van Assche wrote:
> Make it easier for filesystems to submit zone append bios that exceed
> the block device limits by adding support for REQ_OP_ZONE_APPEND in
> bio_split(). See also commit 0512a75b98f8 ("block: Introduce
> REQ_OP_ZONE_APPEND").
> 
> This patch is a bug fix for commit d5e4377d5051 because that commit
> introduces a call to bio_split() for zone append bios without adding
> support for splitting REQ_OP_ZONE_APPEND bios in bio_split().
> 
> Untested.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Nack. This will break zonefs.
zonefs uses zone append commands for sync writes. If zonefs does not have
guarantees that a single write is processed with a single command, the user data
can get corrupted because of the possible reordering of zone append commands.


-- 
Damien Le Moal
Western Digital Research

