Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23308C678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 10:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCGKUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 05:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCGKUo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 05:20:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE18951CB7
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 02:20:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9390721907;
        Tue,  7 Mar 2023 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678184441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROSQSxX8NMQ74KqL7K7Ls25PaUfjrzABn41U2Wo2B0E=;
        b=xUdG8qoZFdCK2rVcUG/YF74OIfX4IlUS8l+PY1Ak+0kyvT1LmA4k2rs44htI74B2r8tGGv
        QM+1QNJOgqQPqS4LSd9wZ+u50aKIbSPh3B3SmwEmgnzUIQeLM2txtexWpP2wySRBsi85N6
        GSD+Obj7rt8d7y4wFTU7XDTwtiRjZvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678184441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROSQSxX8NMQ74KqL7K7Ls25PaUfjrzABn41U2Wo2B0E=;
        b=2kctwW+WWbJzHLV0AdoWrPPp63YX/j/0DzdhEU2CR4wJE5GHMY+562fe+xk8CCceJRPUb2
        dt8CTlLPJEgB/lCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 834081341F;
        Tue,  7 Mar 2023 10:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VdpqH/kPB2ToXQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 10:20:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F30D3A06F3; Tue,  7 Mar 2023 11:20:40 +0100 (CET)
Date:   Tue, 7 Mar 2023 11:20:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
Message-ID: <20230307102040.3t6qiojxj72fqrlc@quack3>
References: <20230307071448.rzihxbm4jhbf5krj@shindev>
 <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
 <20230307091336.p2mzdo225zkoldmd@shindev>
 <076cb738-6f44-e731-d2a6-cad4ff464ae1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <076cb738-6f44-e731-d2a6-cad4ff464ae1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 07-03-23 17:36:19, Yu Kuai wrote:
> Hi,
> 
> 在 2023/03/07 17:13, Shinichiro Kawasaki 写道:
> > On Mar 07, 2023 / 16:57, Yu Kuai wrote:
> > [...]
> > > Thanks for the report, can you help to provide the result of add2line of
> > > following?
> > > 
> > > bfq_setup_cooperator+0x120b/0x1650
> > > bfq_setup_cooperator+0xa41/0x1650
> > > 
> > > That will help to locate the problem.
> > 
> > Hi, Yu thanks for looking into this. Here are the faddr2line outputs:
> > 
> > $ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0x120b/0x1650
> > bfq_setup_cooperator+0x120b/0x1650:
> > bfqq_process_refs at block/bfq-iosched.c:1200
> > (inlined by) bfq_setup_stable_merge at block/bfq-iosched.c:2855
> > (inlined by) bfq_setup_cooperator at block/bfq-iosched.c:2941
> > 
> > $ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0xa41/0x1650
> > bfq_setup_cooperator+0xa41/0x1650:
> > bfq_setup_cooperator at block/bfq-iosched.c:2939
> > 
> 
> So, after a quick look at the code, the difference is that fd571df0ac5b
> changes the logic when bfqq_proces_refs(stable_merge_bfqq) is 0.
> 
> I think perhaps following patch can work, at least 'stable_merge_bfqq'
> won't be accessed after bfq_put_stable_ref() in this case:
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 8a8d4441519c..881f74b3a556 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2856,6 +2856,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, struct
> bfq_queue *bfqq,
>                            bfqq_process_refs(stable_merge_bfqq));
>         struct bfq_queue *new_bfqq;
> 
> +       /* deschedule stable merge, because done or aborted here */
> +       bfq_put_stable_ref(stable_merge_bfqq);
> +
> +       bfqq_data->stable_merge_bfqq = NULL;
> +

I don't think this is going to help. stable_merge_bfqq is used just a few
lines below again in bfq_setup_merge(). The problem really is that the
reference from stable merge can be the last one keeping bfqq alive so in
bfq_setup_cooperator() we need to see if stable_merge_bfqq still has
process references (and cancel the merge if not) before dropping our ref.

So rather doing something like:

		bfqq_data->stable_merge_bfqq = NULL;
		new_bfqq = bfq_setup_stable_merge(bfqd, bfqq,
						  stable_merge_bfqq, bfqq_data);
		bfq_put_stable_ref(stable_merge_bfqq);
		return new_bfqq;

should work in bfq_setup_cooperator().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
