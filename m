Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34801C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376655AbiFVR1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359637AbiFVR1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 13:27:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD62727FCE;
        Wed, 22 Jun 2022 10:27:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7445221C7E;
        Wed, 22 Jun 2022 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655918828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25UMif2KJVLcBXrmfApxtfUU35dfSSw3fpcCICtxyW8=;
        b=VvwAIGoDz+l1mAkHZ7Ci8GmQbbrSdA4ZL7MGpC7pXWaXvzYecJ0zZa3bjiNVxhWwXxQPOi
        c1ahBZimSpktVbRlaNbZivz7OeL07LjMauFEFAtU+9izL/QdsVNVvawoLRT1F257ZjbKfn
        ADVQi1piODXNJyF1VM1Ev4FipKeeVEk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47A7913A5D;
        Wed, 22 Jun 2022 17:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5qGOEOxQs2LFKgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 22 Jun 2022 17:27:08 +0000
Date:   Wed, 22 Jun 2022 19:27:06 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next v5 3/8] blk-throttle: factor out code to calculate
 ios/bytes_allowed
Message-ID: <20220622172706.GA28777@blackbody.suse.cz>
References: <20220528064330.3471000-1-yukuai3@huawei.com>
 <20220528064330.3471000-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20220528064330.3471000-4-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 28, 2022 at 02:43:25PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
> +static u64 calculate_bytes_allowed(u64 bps_limit,
> +				   unsigned long jiffy_elapsed_rnd)

Just noticed with all series applied this argument needn't be called
_rnd. (It's a nit.)


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYrNQ5QAKCRAkDQmsBEOq
uRC5AQC2JzZNZsl22etM1LtHU6Wno1hgy9s1Fj5YailfIQfTJwD/c6sCNnhojsjQ
PCgMBZaodtkg4p+8C/tt1eXOMBvsGgo=
=UiWF
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
