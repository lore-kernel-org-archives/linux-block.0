Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015CC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjC2Xaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC2Xaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:30:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0831A8
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132634; x=1711668634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gcC/1POcjLEFAIcEMXu/G07oqNzLEW5v95BGotn97v8=;
  b=lXhWq++KWzWioyQeaDMgKi/POLadPCJACuZqLyW+tQH2oLjuLlk/gGbE
   t1ThDRwy3RH0ggKo2lcG1dlZrvQQxzVfhl+mFxCqnH+YfAWMfaf/PlDnX
   fYR+SuFfLnv1PJRvJmWtMIoxTMtCGM8u3C/fGTPWVKNkp10BtBtCI4GRC
   LX6HWCHrR0MtjMU/TEspNQk+aCdqMAB2GPXNhlslhOCjxMF6TPA2ujCqA
   SrKN/I2Ifb5Y7BHrRj+FOqR2S1H7J5a68fzHOmL/mVjwccOdUIGpo+Y8d
   74M9fH2WrZKJ5ey48fsy1PJT7r0/P6IrWKD0pmIltQdJ8SBYDNKcqxM6d
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648021"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:30:34 +0800
IronPort-SDR: CEW9QsloOoKi1/Gl6XjGe8lCbs3h3QbMRdtxet+fvffWFH6LY9+/z2kRHXFFmBbJMoKmFDtV4q
 shgyC4ZiDPdX9UsNYmqTVEzKpu3iudVfzbdx5mkjEmwg2o6nWth3e2muv5DACopstVtUXKy/V6
 SJO0FO7JNQuyRKI1cbCPZFr5ocgYaUHEzv8kaJXj73SZTL7GqD+IYqE2n+JtSsm+OofzcizsDy
 7pgQgGp44eLWQtQmyeCuE1C64sdocDFU4XXPBFGMtwq6djejYgV1TusAnIk6iZtbI8zho43GZb
 CLU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:46:42 -0700
IronPort-SDR: JUHdxhOo/mzJ3vmusgiw7S3AAQQAXnJScA/pPvBfeTtdpmmtwZ2Wdd3zcSD4mdkRLyZHgCzdC+
 xlG+cQsxlqiWR43k6F4m06saM9CFU+gwsmXy+FDnnAoBytbIELbBne8qIcNeKEW5GCnPARXNoR
 bYE1KLiZOWilr5dIoi0IpQVk71X+RnVCeO6dWr9ZlJJVzSPwrXg/SUK9jflS6OpDUcOiW/RSpa
 xtLQ3z6ENjRaSNVhUF+PsOwW2elSx7AxbZ6870bvWP86kZeL9K7zfAhwVFhdz8/V0AYRGQfjxo
 21Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:30:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2px4NP4z1RtVt
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:30:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132632; x=1682724633; bh=gcC/1POcjLEFAIcEMXu/G07oqNzLEW5v95B
        Gotn97v8=; b=PoG50HzSd9Sqa3seuCovhxqh1ZZj1r8rRM7hqMVC1Pzrs/Mo8xn
        s2FvS3V47vL7XwXAfrvFNgGFN1/MXXWe6cQDyUrs+uLkmyMiu1ovYiEFYowQ7TUT
        wfa4tqt19MVPZuqNtDeGKyc7ne+kGMaZwH8cyCYGntsekO4jGotJoRJD6DLiPGwu
        os4aw6OxIJRE6l+V9kLg+RXaflepH+nb+xTPHi+u7Tkml5O8gOxvKnBM17WRQIbv
        mQdVhvyFEVMsEnqG8QNoHfx3vNLFW7ITiVKbEkKnZMEik4uxC9t7Y7t1oltQZe94
        VoGnC9Q9Nzo4gA9ee6x9ZTsaAiXIUcMppRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FsD05588qMA6 for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:30:32 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2pt0C0hz1RtVm;
        Wed, 29 Mar 2023 16:30:29 -0700 (PDT)
Message-ID: <4e4aa0e7-f222-f269-1b5c-1abb3a7179e7@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:30:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/19] dm: dm-zoned: use __bio_add_page for adding single
 metadata page
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
 <4a2c46dc0e217a9fb6b9f32d460498a5feb8b67b.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4a2c46dc0e217a9fb6b9f32d460498a5feb8b67b.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> dm-zoned uses bio_add_page() for adding a single page to a freshly created
> metadata bio.
> 
> Use __bio_add_page() instead as adding a single page to a new bio is
> always guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() __must_check
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

