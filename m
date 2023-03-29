Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E4C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjC2XeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjC2XeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:34:03 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830195260
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132842; x=1711668842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GDXEDSyEMJWiW+7+O1GblQg3NUjwO7C813zV/2S0RGs=;
  b=PdS+apfmyf8jz+2mmJbp+FSo1d50agvXGdfVj3AcAa0FTqBEbwISTnCL
   jQARTQov/0nwIjGcEiVK7ZOpysscL3L238/qllhbyCToSB8In8lH/tOu/
   75gXJ7kzJzJyuYwXzCn+1caUQvImwoO7+Jx+/UMSvw1X/m3qSXaCv9aKh
   Y64o5fVlU5sVrzjkwgzWDx+txgyiKolgCB1rZDRvrR4S9/I0tNz/az7FF
   lD1M/BqszOYnUf3G4y3DeGvg6AQpvUofU584f12/owX2z819qIP+D+iZp
   qMSFN+yJTvVEuSBq1+clr7aTzQwNTXTxPUId98RI4AA++fHPSV9rHawik
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648252"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:34:02 +0800
IronPort-SDR: ldwkm0enJkT4DV5RvERfZayATKPPZ7hDgnjFMdrctBO9Xktti9AyYYkdoxBARzdKN23hKI4noe
 ue6o+x7bp2XRhCaNqgg/AtaCAIH9HVONw6bBbc9+z0HcT8MYBe95/CRR92evl+dc9BrAgYC4+A
 v4jbRTet9jTeaFiQK8TxXly5C2YB6a6yNCcmeGja5Ml+il84HiLtnHqgOxz1JhI1OKtgiE8hoE
 dHyLoj1r8fmnxwb/gNd56NH0QfxZ4PxWLCXFnlKbGyLKTTTts90ILP1xCgTeYDY1kWB7NwKyIu
 5E0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:50:10 -0700
IronPort-SDR: JjMPxMSrzWyesVKrtaIlzegI00G3SJDOi4VpCl288Dn8w1q5S80dKyKVL7yAheY9ZCLTuD2cNB
 8/Okf+TW18xLqG+05D2YGeY6VUwmVn6gAMJdQj17hdGoov6b/VAeoWbH2swZINXznudbTn4WdU
 mNtUZMZoTKGHwZ3B1W1e4I/kGGr0TQ3QcObw06peJufwwsPnoeHFTmSnia21YEhEYXz9SDOYKO
 Nf7z9YB1jTuWlpCw83d1Gm+8sCugyYo7OKnm2eg2MadEkXwes4mIWCTBpR2dkc7ZFuWP4xuH/U
 X2c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:34:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2tx4Kqhz1RtVw
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:34:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132840; x=1682724841; bh=GDXEDSyEMJWiW+7+O1GblQg3NUjwO7C813z
        V/2S0RGs=; b=Kl9kIAB48YMkB355tdUzMAD6Lq7A95Cb8NfzVQHNcITpVbKpz5Q
        Bf/AlRacy+pwRPXxv/Y59EYwdHDj+sTzoN5d7khiJg1/fGxSDSjw6dIQly/wyEJ2
        ukCLhjTvrSGecTdk0ROBuOBGbsnuKbXyOPdM7YY2E4Dni8ehYMBTgPC7NIVoKJxc
        8IKPtyMNTgTUJYWyKfuXjNsbQw0QIXDyQWwuAWgSMepI8V9fHAzLY/2GXcTCzi1T
        8EIsd+WBdRLyK8+qPFbQ6B5xdnHCAUKseq3eKeeBNbs9gw2iB6jUvVdXetSvwOGq
        ede4DlUtPAZbbK7Xl0zEQL9cV4gZzJeC4yg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nExsseEpEgW7 for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:34:00 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2ts6Vtrz1RtVm;
        Wed, 29 Mar 2023 16:33:57 -0700 (PDT)
Message-ID: <3f1c6faf-b558-14ba-a2bc-ac12aad41ba9@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:33:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/19] btrfs: raid56: use __bio_add_page to add single
 page
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <5ce38530bc488f9d4f1692d701ca7ad5ea8ca3e9.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5ce38530bc488f9d4f1692d701ca7ad5ea8ca3e9.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The btrfs raid58 sector submission code uses bio_add_page() to add a page
> to a newly created bio. bio_add_page() can fail, but the return value is
> never checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

