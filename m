Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C34C433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 08:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiERIIs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 04:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiERIIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 04:08:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65FE2CDD5;
        Wed, 18 May 2022 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mdeU/OBoZsa66bUz1IFOKaDDTSfpPDuGaocim/rl7HI=; b=mfRjpAdI5vkAnryw319sIBAE4u
        PwvmShN8PR984Iy5Osaw4xlkH4BIUi90zaIyYRvmoZHEa98kfh2qeMwXrfQMbXW9a0Iq0TKbV2Edl
        /BgduzF53HGN/EUN4XRG/Yw7xONhItulcrpo7EwBziCMxJWfwjhHW6XAJt+/vfdRl+/WjRNZU62RX
        58EfjWNJ4s+esrs0h6twDPEtbgxhOjDdvbh9OMdM2aoKZPoW8cyzGuTVOxK8fJSYFamFsn7VorOpA
        ziwLSLezeVQPctq98OGjupG392rCA2+wBQHBVRzrxVKAhxb/N5zStJhQt1KckXzszyMYMtFIEw1T4
        PYzVnNtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrEjU-000Oxi-5R; Wed, 18 May 2022 08:08:36 +0000
Date:   Wed, 18 May 2022 01:08:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, maz@kernel.org, axboe@kernel.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com,
        pavel@ucw.cz, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org,
        tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_svaddagi@quicinc.com,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: Re: [RFC 3/6] block: gendisk: Add a new genhd capability flag
Message-ID: <YoSphB1u4yIwb8rs@infradead.org>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
 <1652860121-24092-4-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652860121-24092-4-git-send-email-quic_vivekuma@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This has abslutely nothing to do with the block layer, and should not
abuse the gendisk.
