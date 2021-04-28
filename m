Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949DCC433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 20:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547CF6143B
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 20:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhD1UCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbhD1UCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 16:02:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557CC061573
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZoZ32WRZZvow/QZKgFzsk5TZ3RLq+q9zAGLLr+PTWy4=; b=fgzDNYx722fbzOimkKLXs1vvvr
        Rf4wOEvpk2DLevYk0fbruicHG95lbfROXnDFM6CltempDdmqX08tfqWj0R4/DWhtiSQnYDjxy5Zco
        nXr1y1eViJTycMkm5RWsV9gKZ3p5DBFjp7IxZGsvz2eQigQeB4CDDpT3NJvik6pD/OVXuxv5Xe5K6
        lpGPKXX9vFN4lecULWoE8afb7y8ay3EYSAdCPTMhyUnrIv3sl+4nDL3TJxQP5j6/Yw/BXiYY5Xl/i
        VUTuQbYIZhF1iSmlNlI2LKKt9j8eI0UnB300YIe4W2HCnr0QUAmc/zbTOwlInIENk+QrjaEk2pYb6
        5lxXC3HA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbqMK-008keI-E8; Wed, 28 Apr 2021 20:00:58 +0000
Date:   Wed, 28 Apr 2021 21:00:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: bio_add_folio argument order
Message-ID: <20210428200032.GC1847222@casper.infradead.org>
References: <20210428165044.GB1847222@casper.infradead.org>
 <7be8f00a-1444-d614-267f-1477289e4f62@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be8f00a-1444-d614-267f-1477289e4f62@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 28, 2021 at 10:58:44AM -0600, Jens Axboe wrote:
> On 4/28/21 10:50 AM, Matthew Wilcox wrote:
> > bio_add_page() has its arguments in the wrong order:
> > 
> > extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
> > 
> > Oh, right, and the prototype commits the cardinal sin of just giving you
> > a pair of unsigned ints and doesn't bother to tell you what they mean.
> > I'll send a patch for that ... anyway:
> > 
> > int bio_add_page(struct bio *bio, struct page *page,
> >                  unsigned int len, unsigned int offset)
> > 
> > This fails to follow #4: https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
> > 
> > Here's what I want to do for the folio equivalent:
> > 
> > size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t off,
> >                 size_t len)
> > 
> > This will make the transition more painful, but it does remove an irritant
> > for the future.  Any objections?
> 
> What's the point in shuffling len and offset around?

That almost everything else does (off, len).  Grepping include, here's
the (object, len, off) examples I found (will miss multi-line examples,
tried to use my best judgement, tried to exclude loff_t):

bio_add_zone_append_page
__bio_try_merge_page
__bio_add_page
bio_integrity_add_page
fscrypt_encrypt_block_inplace
fscrypt_decrypt_block_inplace
sg_set_page
sg_copy_buffer
sg_pcopy_from_buffer
sg_pcopy_to_buffer
sg_zero_buffer
copy_linear_skb

versus (object, off, len):

bpf_ctx_copy_t
->is_partially_uptodate
memcpy_from_page
memcpy_to_page
memzero_page
(basically all of the iomap functions)
kvm_write_guest_page
kvm_vcpu_write_guest_page
skb_gro_remcsum_process
nf_checksum_partial
perf_copy_f
read_module_eeprom
skb_frag_foreach_page
skb_to_sgvec_nomark
skb_to_sgvec
skb_send_sock
various skb_checksum_ops
sk_msg_clone
various gss_krb functions
xdr_process_buf
usercopy_warn
various network getfrag functions

Not _quite_ as one-sided as I thought, but there are basically three
families of functions (bio, fscrypt, sg) that are len-first (plus
copy_linear_skb() is out-of-family), then networking, filesystems,
highmem, perf, bpf, kvm are off-first.

So, you're the maintainer, it's your call ... do you want bio_add_folio()
to resemble the bio_add_page() calls as much as possible, or do you want
to migrate towards how the rest of the world works?
