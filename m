Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355CFEB64D8
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjFPH0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbjFPH0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:26:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A526A9;
        Fri, 16 Jun 2023 00:25:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52BC767373; Fri, 16 Jun 2023 09:25:55 +0200 (CEST)
Date:   Fri, 16 Jun 2023 09:25:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
Message-ID: <20230616072554.GA30156@lst.de>
References: <20230615030837.8518-1-schmitzmic@gmail.com> <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de> <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com> <20230615055349.GA5544@lst.de> <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com> <69ecfff9-0f18-abe7-aa97-3ec60cf53f13@gmail.com> <20230616054847.GB28499@lst.de> <80ffb46c-b560-7c4e-0200-f9a91350c000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ffb46c-b560-7c4e-0200-f9a91350c000@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 16, 2023 at 07:20:52PM +1200, Michael Schmitz wrote:
> Am 16.06.2023 um 17:48 schrieb Christoph Hellwig:
>> On Fri, Jun 16, 2023 at 07:53:11AM +1200, Michael Schmitz wrote:
>>> Thanks - now there's two __s32 fields in that header - one checksum each
>>> for RDB and PB. No one has so far seen the need for a 'signed big endian 32
>>> bit' type, and I'd rather avoid adding one to types.h. I'll leave those as
>>> they are (with the tacit understanding that they are equally meant to be
>>> big endian).
>>
>> We have those in a few other pleases and store them as __be32 as well.  The
>> (implicit) cast to s32 will make them signed again.
>
> Where's that cast to s32 hidden? I've only seen
>
> #define __be32_to_cpu(x) ((__force __u32)(__be32)(x))
>
> which would make the checksums unsigned if __be32 was used.
>
> Whether the checksum code uses signed or unsigned math would require 
> inspection of the Amiga partitioning tool source which I don't have, so 
> I've kept __s32 to be safe.

Well, the return value of be32_to_cpu is going to be a assigned to a,
presumably signed, variable.  With that you get an implicit cast.
