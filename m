Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6CC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjC2XiW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjC2XiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:38:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9A4200
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133097; x=1711669097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=trSlsKzGDIdMPkatCLLhm/IW4lDqvQLyF89j6Acxt+c=;
  b=pal8pLcWdxq/0mAb1iBhU1FqZcJB/I44VQ4z3DZitZAJeI5gHWUL2CgV
   GG3f8zDyHFWEgCusnjw0hBFKgOMVp+KsmCseJzRe1T2b8ojnEIclRgcxE
   QwpasXEZZZ7fsYI6Zlvrj4uVpc73psO1wEv8RwnmQDAwbm/z8sYwVO6x/
   m7VOIa2TzQ6KgmksyF+wq9iuAGcBqyJLixHIYt5KcdNWC14AeLMyjTCLT
   VcbtUdwnGJDsCZXvV+VgGWiRqXQUSHx64RLIzdciLeDnrp3e0irVCnc6+
   bQjABLp50I+8Q+MQxxV3ttd5vE3N+0UL2IUx78fdDrV0TpTNu0rv2kk9U
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648452"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:38:15 +0800
IronPort-SDR: 9XyLbqD4x+cdz4LDYlNXssXuw1hsA/utMWtYep5n7NPultj2itIdiDTwWDMd4FNThoHoj4TqG3
 7pkWXP4HN7alqp1p7X39PlPFEY62Y6+MGpCcFWVCsTv4+f77520X4sxwVxL+y5HjqXemDOA2lI
 /9HneEFBLKPFV7xiF3YQdTp/nVhLWuMs4mbreViployFtSfmlnfoLY04LgLrPE5jvQmmlnN72Z
 W0qr0pgct0opCYROkSmKQKLm50or2vUubBRqm5P75qHLofKX2AxJHvxNdieOD4vwrgJjS3P+nQ
 KfA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:54:24 -0700
IronPort-SDR: vaFJdE0qjMlhraJGWtjPHJG/hCcU5Oid6A5ODTrBdooMKI6CtANe0MlimndxM7lLJs5/E9upxS
 jocDOIfY6HtyAR5WaiUYWOlrFr1EVOQOUlEqQjZMHBOs9Vw/yciVIBbTJMJ3c1wk+Qp8aamROw
 xmLpm/wYaaM+XcnlUYXBQvEmLLlyWPwiuJPJ6SrXwwuLZmjbToOVMhlKCMG2JF+G9aYxPZtQv2
 YcN4hAY0g13LPYwCR5lWx5hg8pYFlPp1Z4Udh/WYF4xEIQBBmRQHMOGiGInoJw1Hd7RhEHileO
 rhI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:38:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2zq1YXbz1RtW3
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:38:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133094; x=1682725095; bh=trSlsKzGDIdMPkatCLLhm/IW4lDqvQLyF89
        j6Acxt+c=; b=IwLM6OxTQ5LWzxAC4NcyXZ1dr2nvfgOzo9MYnLjHJuGsYvXhajL
        hlDO/OUe2nXi2knwvLTDrpf7NjCBruC2QzmIpB4JE9IyVsUJJAG/YLLsSyvDJh6t
        qxwxrHBhyTsmBCFnvPnxGjsvWVabw/lioMS9Htl+JJJqa4JvEgAHA2zECs+RUwul
        t+dnEFKBLZOQyEWCGPk1uA6JA048hYHWTFe/WWVJRogq+WSguIeHywIZ5y4oQkjK
        dU94SWBhAlGUm9MArYUGt90AtfkGpTivTX688Qa5D0tXrxVoC2lWcu6DZA0NboRO
        DWfvkb0SzT2gUKXzOI9on0y1QnPiBSGbu9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pSu9w0EnMjUr for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:38:14 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2zl2Krzz1RtVm;
        Wed, 29 Mar 2023 16:38:11 -0700 (PDT)
Message-ID: <546786e3-79b3-f9d0-008c-23d2de7eb3de@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:38:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 15/19] md: check for failure when adding pages in
 alloc_behind_master_bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
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
 <76f5748e386870c034b46e919101a878b87a79bf.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76f5748e386870c034b46e919101a878b87a79bf.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:06, Johannes Thumshirn wrote:
> alloc_behind_master_bio() can possibly add multiple pages to a bio, but it
> is not checking for the return value of bio_add_page() if adding really
> succeeded.
> 
> Check if the page adding succeeded and if not bail out.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

