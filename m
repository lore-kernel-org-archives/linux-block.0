Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7358CCA481
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiGNPaz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiGNPay (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 11:30:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3E4E615;
        Thu, 14 Jul 2022 08:30:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE80F33FC3;
        Thu, 14 Jul 2022 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657812651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qjqT7SoxoR9mTBoMZMCI7jluhIaJmn/utMED2HCl/Q=;
        b=EiHzMxDmlU7EFkfaKGQ3NPyWR/nQ/wJVfS/BfupL2vMMk58MErRaeDyeGYGNDzxwKFgnIt
        30I0tn0r+DT3V4zqPunRblVvDPgUA2cOt255YYKdRdSFQl6xdR8noYXbKZBcbV04eDnI2x
        xoRaK24x0c0usq3+HWBlsb1ZpfDHCuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657812651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qjqT7SoxoR9mTBoMZMCI7jluhIaJmn/utMED2HCl/Q=;
        b=AtG53+dMYDD2TdTwBe3wsKp7lrtNO3JD78sVC3LoZbBzIqQIb+wtYbhF9Av4AwOJdyu5Cg
        30nEAemoaiE2K7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEB5913A61;
        Thu, 14 Jul 2022 15:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yxZrMqs20GLUTgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 14 Jul 2022 15:30:51 +0000
Date:   Thu, 14 Jul 2022 17:30:51 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, hch@lst.de, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, asml.silence@gmail.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Message-ID: <20220714153051.5e53zgkcabb7ajms@carbon.lan>
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
 <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
 <Ys+QPjYBDoByrfw1@T590>
 <20220714081923.GE30733@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714081923.GE30733@test-zns>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 01:49:23PM +0530, Kanchan Joshi wrote:
> If path is not available, retry is not done immediately rather we wait for
> path to be available (as underlying controller may still be
> resetting/connecting). List helped as command gets added into
> it (and submitter/io_uring gets the control back), and retry is done
> exact point in time.
> But yes, it won't harm if we do couple of retries even if path is known
> not to be available (somewhat like iopoll). As this situation is
> not common. And with that scheme, we don't have to link io_uring_cmd.

Stupid question does it only fail over immediately when the path is not
available or any failure? If it fails over for everything it's possible
the target gets the same request twice. FWIW, we are just debugging this
scenario right now.
