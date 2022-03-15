Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E591FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 08:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbiCOIoJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbiCOIoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 04:44:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA7B10
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZBjfnoRrOMDhySeEmtfphRYvbSg/gQAQ7DlhAjwUStM=; b=GXjGcoo/nyLhFyaRYS6O8d2zYe
        no3n6yg0inlwCaOzc+jyivDmZlhcUKoi12AKMyKMoVf3K98qty64ig2tmqjQ9/y5c9Moz9SYGr5Je
        EIRI8MVdKl+eZHEor6kgFpind8m49R0yPXWdIvzWnliEzWpTF8k3NUtmmCMNZOAFynQbrJuNKRTpl
        wU5hAlMhxTPr5RBhw/SQJQ6y/4+3s0HrO1ZkJ+P7gLCBQQTM4s0ODcW0p+7FjFAXYFtbdwkcQrkqq
        CHOCAVQ3Vnl6lxtAfrNBuNkr/6nfvhTFO7YyOcxRczWV70jR4HyJ8I6OYf0o1tGYWFw6Sj8cxaSx/
        2iql3ERQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU2lR-008Jyd-08; Tue, 15 Mar 2022 08:42:45 +0000
Date:   Tue, 15 Mar 2022 01:42:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YjBRhKsKMg3BMZtC@infradead.org>
References: <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
 <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
 <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
 <d2950977-9930-1e80-a46d-8311935e8da4@grimberg.me>
 <YjBKaoBYtofJXrgw@infradead.org>
 <1cec32d1-511e-1a78-b157-9ecaebc72c66@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cec32d1-511e-1a78-b157-9ecaebc72c66@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 10:38:24AM +0200, Sagi Grimberg wrote:
> 
> > FYI, I have absolutely no interest in supporting any userspace hooks
> > in nvmet.
> 
> Don't think we are discussing adding anything specific to nvmet, a
> userspace backend will most likely sit behind a block device exported
> via nvmet (at least from my perspective). Although I do see issues
> with using the passthru interface...

Well, anything that is properly hidden behind the block device
infrastructure does not matter for nvmet.  But that interface does
not support passthrough.  Anyone who wants to handle raw nvme commands
in userspace should not use nvmet.
