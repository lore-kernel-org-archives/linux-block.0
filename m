Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA89C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjC2X3W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjC2X3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:29:21 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9611BCD
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132560; x=1711668560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a+NVpLO2XQBp6iZs+ex8RERrDcsLfBZuQOxHVIXweuE=;
  b=jgnC4uynYAdv5p8bHG8BimpLBrnLpMQpMbKLtHxpP9jwiUBh5wXCLSQ+
   KOJmKYRithKlQ0ndoBDzv5wVNeENaqhyFS9T1cw6gbBUQn0KdExZnmUu2
   AVnEsvUb2UL0kyvi0BTvy5ZZXlbBOB7Hc8gpRszjMCJ7GCaTAGvzLQmtp
   porO3OjtCUzvHIvkzkSzVFeXf40k3VwUBmnLtKm5nv1x51IufII3tUKsY
   zCkRp84NZfsNeVvuJ9f6NN93Ru3YYrkVwR9SQ6PRkdIsqyTh9IqLd/AuX
   jcxtIwxApDuQt1lUg6g9Zuh3zBErQH/CksVqsOX+WVNRCnVRkR2FKw1om
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226647942"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:29:20 +0800
IronPort-SDR: jjlgAviPAEeeIT5pOKNGT/YaaL9SLEaalVxdGk7LQAiiJmJCu5bQxstNH9L4eFeQudpcLXq5Lm
 FMlWjsosOYliZKZmLaZigoXPVr3oxjxKSE5j45X5JURKTMirOVJIxQNzDSox+P8X9t+FGaCE9Y
 KL5Nd49r80LgZ+F/9gYJqoi4MmUv6WCRPnLD5NpYVzVkmbPUphuTQJCF1AFbVcQuzytxM+9YpL
 9q882KdbFy/yFhmoCjCZ5rKlar68WFryuwpzQ/T2s0brUK3E6+8hV0ZOVAf3GUYe/Pk4EK6WQy
 7ZY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:39:49 -0700
IronPort-SDR: ofxHlFFgkSxG0xgD0UG5TTbqpau76MuOi4W7VjyO85lgitdmgp9DnyMZhf9po+H8je4qclG+bN
 /THb9jim3wXZVJBCzZ4Q2+0SiqE++CQmsIT0Wro+86qWOIWrramTRFCWHrVFV4HNWzh07CMWED
 nwZwqOjiDTy89F3WdglPccTDHzuI5qMdzewFZZ3tc3hgRPhfVZp8wGWt1S+cYL4EQ8fAxjyz5X
 jUw1t8W63KpfTrtrH7tmhFH70eZImgZ1GEWso7E/fqyzoSi9xisXBUWfO+BW3dYmA28x2WZ/Fi
 9Lk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:29:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2nX173Cz1RtVv
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:29:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132559; x=1682724560; bh=a+NVpLO2XQBp6iZs+ex8RERrDcsLfBZuQOx
        HVIXweuE=; b=ey2f3kk11MiZ8fW2lBsVE6iqLCNprO9dciEEFxTXxN+atK95JFm
        GeL4fdna7sGh5OA3GyhTl6dDgM1awPXCw/oh0ur/h+S4H1cvx8Kq82Mw1Vc30qtY
        Nl4miDGl6PutBI7w7Ra2ULynQ0KRR2jk5wsVgu1BGOTa2pU2ZCzd8135B1HLnAHe
        bwtsBUtPmdPVK5BZusnYQ0LO/k1J1+NHVVOZRXZOFswL4vtTAlv9VzJwO/o1EGqz
        GHmTvBtmOh6QS/VJ7nCVRUApfB8c0Gn/ArE3TTpQ9cCBP794K0T3HJ8VeF0pNwdv
        NXyennxT++lsXIsW0TYKGI/+C0BsoiTHPVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RoIAvrV3jqWQ for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:29:19 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2nR75BJz1RtVm;
        Wed, 29 Mar 2023 16:29:15 -0700 (PDT)
Message-ID: <a3e8f1cb-4d76-dcb0-41a7-43b015d25dd4@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:29:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/19] swap: use __bio_add_page to add page to bio
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
 <7849b142e073b20f033e5124a39080f59e5f19d2.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7849b142e073b20f033e5124a39080f59e5f19d2.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The swap code only adds a single page to a newly created bio. So use
> __bio_add_page() to add the page which is guaranteed to succeed in this
> case.
> 
> This brings us closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

