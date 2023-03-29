Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04705C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC2Xg2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC2Xg1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:36:27 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9735251
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132986; x=1711668986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OTfJOB5+rMhAgZTM4ONfC4vlfxhMaFKo471fkAaO7qM=;
  b=epaJ3aW81IaeRZzL9UC2EDNTqmYWc2zXzLfG+a9QgaksoMQpfizqU3QR
   1zulr38OsWAIvMwOUxLIdrGYTqXPuh+N5RgHPFz3Fv0VYIhBLSDTbbbtH
   YSTU0Cf7gmit2UTjc0Trnt2iDV66FhB9dgv3mbMOmEQmNE5UV7EmBJ84H
   rNtPNGliBrvG8ahrL+yn1CBmzwUvdlZ41XWHJW2qW0GcS09SdnxzmjZ/d
   6KOqPr8Dn6TEvzNc7ODCvnT3Kvy+8m/IUdKXpAydRXOyAZ9VDLI08X0h3
   bG4RZkp+m+bJuTVfOiANDTfvMqhhvaxuK00g7v557QV6QZGLkwWQ0GNRD
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828697"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:36:25 +0800
IronPort-SDR: CwT1tkhxOTtTqIN2++uOeflxT69MG4Ke2g1PlkoADut2XSjQi2Wn5XtLqQeHQ5GRMWQW4RnChz
 Xl0VS9huRF+POvzxImVe0tXMBn48iJ1OiEldMBWoRyZAvBiG2QoiEKmFZu+JjyZTcnXxhCpuM3
 QUMxFBJG9J0GXUHKJUTbt1zZuAfzmkbzKhHPExLONKznSDWEVc19VhzmXjwDmJUlyiyKFsGnmS
 c1N0r939VULEXfwWUwzkCvWdyJtaah3aQQ5UI5OBPG1A9HOjX1krkX36tBD28eKtjdb6EDTge6
 OsQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:46:53 -0700
IronPort-SDR: b9DFXNMtPbCQS4zF1L3m6wuXK3G95yovwCknrRbR83AU2P0K5BDXOQZpniid8h4YFFvZLKAWbi
 XKlIUnbYW4QfHz1LQd+Gi3o3yq7R87qpxM26+k2nXPHsctB156YWqGFpZPtXAlVwiCzjgZziBY
 +ZTLyYpBzGnYI16b2S4vFKOMBLIfPIzTTtjwQ3X6Zn1zRrRBNv4PGavwoCgTUtTIb+MxWbOsaX
 4RGhpCNU3bHGNEYWV35I1ac9SJvibg8sJZ/YUvQA9Pb/ral4LIKDwQ33ZGxVBrWNsZAWmG5dzO
 Ggg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:36:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2xj3s99z1RtVv
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:36:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132984; x=1682724985; bh=OTfJOB5+rMhAgZTM4ONfC4vlfxhMaFKo471
        fkAaO7qM=; b=iA9ESw9qffKNSFDF3ok630RxnvZTTZvVjdgrC2mRPtNl91Z08Bz
        yihPfnkjRCVwpEa0rK+4D2u0qY2ZZWg97ju7UgczJYkMP/zXgwrfenICqIC32DuN
        2Hd749Yv3hAEPotkgbr4/VjJEvWNMpSPZPwBnUUQR6kPTixNsWpB34Uws1Y9pYv2
        BfpUFjvU1jp89f0qVou4HeTsGlk6+qUWG0JnkHbEMPegxcMpkqmAElk36HNq8vKC
        3vtHABssq94tgixRpIzjnFDkx9+ZPQ7qPcOq+YMmOo5kQtPsrUishTIa5S7BDEKT
        Z9i1qF9rzU21n3jHrd3Ow6BexmdN0fTC9TQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id or4wNseXYG9O for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:36:24 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2xd5qYJz1RtVm;
        Wed, 29 Mar 2023 16:36:21 -0700 (PDT)
Message-ID: <329c915b-b49d-491f-80ef-f4c9cdf80600@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:36:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 13/19] zram: use __bio_add_page for adding single page to
 bio
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
 <339841b3b7ce6b2faf56bcaf9d92e298d878ef64.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <339841b3b7ce6b2faf56bcaf9d92e298d878ef64.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The zram writeback code uses bio_add_page() to add a page to a newly
> created bio. bio_add_page() can fail, but the return value is never
> checked.
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

