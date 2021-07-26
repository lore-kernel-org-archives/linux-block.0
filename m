Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F1C4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 10:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377CA60F22
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 10:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhGZJ5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232490AbhGZJ5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 05:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627295868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5ZEVbSWh7t3DiH6T7x7erAZjIhqrWggfLOykN1elKU=;
        b=T1+AG5LEB2pmZeh25n2ENS40VhkORwCGSu25PwzaGJMhT2WdN7lzFGTwsUUPLnj5+U9GoV
        PRCIg18ID8PVsTgwoAIq/xnLdw4rbu0mTVoczEpS+v6UDtGp7b4JQVmzyHRFEBADSYbvVi
        3tNbe/9DFJ/WqPBwEe3YRAbrILv9qN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-iPwaxfwOPk2lzY3tp6rC2A-1; Mon, 26 Jul 2021 06:37:47 -0400
X-MC-Unique: iPwaxfwOPk2lzY3tp6rC2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 361151008065;
        Mon, 26 Jul 2021 10:37:46 +0000 (UTC)
Received: from T590 (ovpn-13-107.pek2.redhat.com [10.72.13.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDFC05F705;
        Mon, 26 Jul 2021 10:37:34 +0000 (UTC)
Date:   Mon, 26 Jul 2021 18:37:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 0/7] genirq/affinity: abstract new API from managed
 irq affinity spread
Message-ID: <YP6Qa8gWmbZg+HAN@T590>
References: <20210719095729.834332-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719095729.834332-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

On Mon, Jul 19, 2021 at 05:57:22PM +0800, Ming Lei wrote:
> Hello,
> 
> irq_build_affinity_masks() actually grouping CPUs evenly into each managed
> irq vector according to NUMA and CPU locality, and it is reasonable to abstract
> one generic API for grouping CPUs evenly, the idea is suggested by Thomas
> Gleixner.
> 
> group_cpus_evenly() is abstracted and put into lib/, so blk-mq can re-use
> it to build default queue mapping.
> 
> Please comments!

Any comments on this patchset?


Thanks,
Ming

