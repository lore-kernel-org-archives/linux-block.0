Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CFDC10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 21:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE320693
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 21:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MlUaT5mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfDRV5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:57:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45122 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDRV5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 17:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T3gahklMMlmAdxs/1TrGgTz2aV7A/nBCyInv02Ahbug=; b=MlUaT5mnagR5NTQhsSKqiWB3+d
        Sk7ryvjtw8Din3FmXhEO5Bcm86IFLAkjtrXos1mQwONyJJgZJbpdWJubnb5ZkOYAr1NBJgn2E2b30
        mPBMl4YxUetfVftkTONBAD+5463RUMTGaVmaHsPwrNuiwv/j1xO1+3LuNXoYO4mspgbBmB2pZfSNv
        j1frRxYfMwF+VqHSacNbcggTyK5XFdrsmWLOPRLs3wsVeYDFk1V9W6jYKJaZLiSMGB1xnH8HfsCsf
        T5wAdiG75R1w5dqBfoKecEqxf6g3OHSpz/8ODEEHq7QovMM9T47ka9A8auZ+Icv+dPz7qkl9U9xCM
        3fzM8nlQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHF1h-0007JF-UZ; Thu, 18 Apr 2019 21:57:02 +0000
Subject: Re: [RFC PATCH 1/1] lightnvm: add lzbd - a zoned block device target
To:     hans@owltronix.com,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Klaus Jensen <klaus.jensen@cnexlabs.com>,
        Simon Lund <slund@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <1555588885-22546-1-git-send-email-hans@owltronix.com>
 <1555588885-22546-2-git-send-email-hans@owltronix.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <341dfda3-40cd-0ad4-b0f0-0d488d523d58@infradead.org>
Date:   Thu, 18 Apr 2019 14:56:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555588885-22546-2-git-send-email-hans@owltronix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 4/18/19 5:01 AM, hans@owltronix.com wrote:
> diff --git a/Documentation/lightnvm/lzbd.txt b/Documentation/lightnvm/lzbd.txt
> new file mode 100644
> index 000000000000..8bdbc01a25be
> --- /dev/null
> +++ b/Documentation/lightnvm/lzbd.txt
> @@ -0,0 +1,122 @@
> +lzbd: A Zoned Block Device LightNVM Target
> +==========================================
> +
> +The lzbd lightnvm target makes it possible to expose an Open-Channel 2.0 SSD
> +as one or more zoned block devices.
> +
> +Each lightnvm target is assigned a range of parallel units. Parallel units(PUs)
> +are not shared among targets avoiding I/O QoS disturbances between targets as

(prefer:)               targets,

> +far as possible.
> +
> +For more information on lightnvm, see [1]

end with period above, as the 2 below are done.

> +For more information on Open-Channel 2.0, see [2].
> +For more information on zoned block devices see [3].
> +
> +lzbd is designed to act as a slim adaptor, making it possible to plug
> +OCSSD 2.0 SSDs into the zone block device ecosystem.
> +
> +lzbd manages zone to chunk mapping, read/write restrictions,  wear leveling
> +and write errors.
> +
> +Zone geometry
> +-------------
> +
> +From a user perspective, lzbd targets form a number of sequential-write-required
> +(BLK_ZONE_TYPE_SEQWRITE_REQ) zones.
> +
> +Not all of the target's capacity is exposed to the user.
> +Some chunks are reserved for metadata and over-provisioning.
> +
> +The zones follow the same constraints as described in [3].
> +
> +All zones are of the same size (SZ).
> +
> +Simple example:
> +
> +Sector	 		Zone type
> +		 _______________________
> +0    -->	| Sequential write req. |
> +		|                       |
> +		|_______________________|
> +SZ   -->	| Sequential write req. |
> +		|                       |
> +		|_______________________|
> +SZ*2..-->	| Sequential write req. |
> +		|                       |
> +..........	.........................
> +		|_______________________|
> +SZ*N-1 -->	| Sequential write req. |
> +		|_______________________|
> +
> +
> +SZ is configurable, but is restricted to a multiple of
> +(chunk size (CLBA) * Number of PUs).
> +
> +Zone to chunk mapping
> +---------------------
> +
> +Zones are spread across PUs to allow maximum write throughput through striping.
> +One or more chunks (CHK) per PU is assigned.
> +
> +Example:
> +
> +OCSSD 2.0 Geometry: 4 PUs, 16 chunks per PU.
> +Zones: 3
> +
> + Zone	  PU0	PU1   PU2   PU3
> +_______  _____ _____ _____ _____
> +        |CHK 0|CHK 0|CHK A|CHK 0|
> + 0      |CHK 2|CHK 3|CHK 3|CHK 1|
> +_______ |_____|_____|_____|_____|
> +        |CHK 3|CHK B|CHK 8|CHK A|
> + 1      |CHK 7|CHK F|CHK 2|CHK 3|
> +_______ |_____|_____|_____|_____|
> +        |CHK 8|CHK 2|CHK 7|CHK 4|
> + 2      |CHK 1|CHK A|CHK 5|CHK 2|
> +_______ |_____|_____|_____|_____|
> +
> +Chunks are assigned to a zone when it is opened based on the chunk wear index.
> +
> +Note: The disk's Maximum Open Chunks (MAXOC) limit puts an upper bound on
> +maximum simultaneously open zones (unless MAXOC = 0).
> +
> +Meta data and over-provisioning
> +-------------------------------

My dictionary searches all use metadata as one word, not two.

> +
> +lzbd needs the following meta data to be persisted:
> +
> +* a zone-to chunk mapping (Z2C) table, size: 4 bytes * Number of chunks
> +* a superblock containing target configuration, guuid, on-disk format version,

what is guuid, please?

> +  etc.
> +
> +Additionally, chunks need to be reserved for handling:
> +
> +* write errors
> +* chunks wearing out and going offline
> +* persisting data not aligned with the minimal write constraint
> +
> +The meta data is stored a separate set of chunks from the user data.
> +
> +Host memory requirements
> +------------------------
> +
> +The Z2C mapping table needs to be kept in host memory (see above), and:
> +
> +* in order to achieve maximum throughput and alignment requirements,
> +  a small write buffer is needed
> +	Size: Optimal Write Size (WS_OPT) * Maximum number of open zones.
> +
> +* to satisify OCSSD 2.0 read restrictions, a read buffer is needed.

        satisfy

> +	Size: Number of PUs * Cache Minimum Write Size Units (MW_CUNITS) *
> +	Maximum number of open zones.
> +
> +If MW_CUNITS = 0, no read buffer is needed and data can be written without
> +any host copying/buffering (except for handling WS_OPT alignment).
> +
> +References
> +----------
> +
> +[1] Lightnvm website: http://lightnvm.io/
> +[2] OCSSD 2.0 Specification: http://lightnvm.io/docs/OCSSD-2_0-20180129.pdf
> +[3] ZBC / Zoned block device support: https://lwn.net/Articles/703871/
> +

thanks.
-- 
~Randy
