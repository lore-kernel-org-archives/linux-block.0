Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E582EC76196
	for <linux-block@archiver.kernel.org>; Sun, 26 Mar 2023 01:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCZBpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Mar 2023 21:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZBpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Mar 2023 21:45:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222ABDEC
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 18:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679795113; x=1711331113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H21o1mDQGkPTA4z2c2fBvsusGp431Pnz1A5OGyJo3qc=;
  b=FnFVrceiACKnwNtZga3QoZovM0M16tYfNogMU8IQk8gUpSGGq94XoHtB
   Mqyrm8MY7YTVu+Sxjl5reuhJk+R3GUPmGrNucG8liuPjHaqZUqiwIn/tp
   DuWg/acAzg/dZTNecYBp/lRtyLRcnK8fa/FH4qAJumwLFivNXYWsH8FXi
   YS1Vst3GVduNWiOFJ6DyJsOvNEaOz4FuqwbWzXrQKZcHWd079TIlRwmkw
   n2ZIw4cUbRM3IH5CWZG2qJ0wgAYCZO1yvdetOm2Ax7pJLHxWdPt/eJX4L
   9ClatHsPUXLq0cuuILKJ7NmEauwR+cSHQdV742+uDo7j0fjESXG87SlXE
   g==;
X-IronPort-AV: E=Sophos;i="5.98,291,1673884800"; 
   d="scan'208";a="338570321"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2023 09:45:12 +0800
IronPort-SDR: q/UUPnS5k96j6Cr0dWSxSnA2pCyINu93aSuHX6W7xhFBRs6a1uNCYfP84v1fpqe+8kOoPTPZV3
 Q586krd+FHzk9ryM0Ia8ppBKEB9LlVNqmGMcUQ/ltY3LZNSmFuJ0VqKQiVZLFNJdfBO2EuwY8E
 926989goQnAJWsLIIEB9vJ/FUceLJncshar3PFl6AsRQRcS4j5U8MVhS8/nBAQ43LTOHdQNNvh
 3c7qRBw8o9nhORX6A2dcEcA1t1u7251h838zVe+fLAngb+eU5R90ZLw8eDsgLJoDqvMK0puyYo
 a7c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 17:55:45 -0700
IronPort-SDR: ebKMYbyIh0YJT6yBa1/sr1hL3fIfWhBWBxOK27MgRwIP7iNdRzUD+AhgZ5FBAQ0yrBwsAozIkE
 6glfHe8biJ1Uk8KQl2XlyeJ11TB8IlYiW0yweC1rb+ZqNzVqAOnhmzAcxBi4oFdruKYyDhpPJv
 DQn1bjGN+C5rnjFQtEGoGpLEyWJ9Q2QHo9S9YFgCSogQZKPxwtChx+DAbcvi2Jpr4lzxrfX2mX
 nz7QdG2BAR1ud6Pi4VJKMNoIFeRQq3bS/9SIqpOPDsGdxgq0+D5fA2yt/qhmH3dKs0JKqWDB8t
 NHY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 18:45:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pkf08288Kz1RtVx
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 18:45:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679795111; x=1682387112; bh=H21o1mDQGkPTA4z2c2fBvsusGp431Pnz1A5
        OGyJo3qc=; b=XwMLCap9zWsUxPDcIyiS66DA8WrYWbZHRMOyJh6n+5WwA5MnHmA
        1/0R8oTJEhGh6FAkwEiBxWV5NPCgmz9y/rzdarKcFSy+IP+mmfRaTAZsnMc/dWtW
        pgVU64GxzPsF7wN8Szp3lcPUZKtuH0bUqd166N7RHbZn6dQnfZUgm0NTiRiv18jQ
        GITQGlENc8iohJ4eOak+VL0WP1KRgSV6k5InrTfHf8BBha3mp2dgyGgvgo6dA3An
        rOQAyHyDwpewZEYJuU35mwROtWzuzetJWUyMMxn3aekT9FrVerUwa9/8rmb/Q5VD
        2CoZ3cZrfzU+bCQjtf5rIsemdj9f34nhcig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y1YhpCLnm-na for <linux-block@vger.kernel.org>;
        Sat, 25 Mar 2023 18:45:11 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pkf061Kcyz1RtVm;
        Sat, 25 Mar 2023 18:45:09 -0700 (PDT)
Message-ID: <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com>
Date:   Sun, 26 Mar 2023 10:45:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <20230321055537.GA18035@lst.de>
 <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
 <20230323082604.GC21977@lst.de>
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
 <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
 <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
 <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
 <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com>
 <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/23 01:31, Bart Van Assche wrote:
> On 3/24/23 19:00, Damien Le Moal wrote:
>> The trick here could be to have the UFS LLD to unlock the target zone of a write
>> when the command is sent to the device, instead of when the command completes.
>> This way, the zone is still locked when there is a requeue and there is no
>> reordering. That could allow for write qd > 1 in the case of UFS. And this
>> method could actually work for regular writes too.
> 
> Hi Damien,
> 
> Although the above sounds interesting to me, I think the following two 
> scenarios are not handled by the above approach and can lead to reordering:
> * The SCSI device reporting a unit attention.
> * The SCSI device responding with the SCSI status "BUSY". The UFS 
> standard explicitly allows this. From the UFS standard: "If the unit is 
> not ready to accept a new command (e.g., still processing previous 
> command) a STATUS response of BUSY will be returned."

Yes, that likely would be an issue for regular writes, but likely not for zone
append emulation using regular writes though, since a "busy" return for a ZA
emulated regular write can be resent later with a different aligned write location.

-- 
Damien Le Moal
Western Digital Research

