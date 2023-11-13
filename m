Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EF22318
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KZNAjkMg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gbkTgnY5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB11702
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 08:18:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF5FC2191A;
	Mon, 13 Nov 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699892304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqBpMF6+W/H/NdkcPSZDiyEXyNi38LQ4S3FcnkyXMPc=;
	b=KZNAjkMgC8t4PthC6FscdPyMa+pyp/EfvvYZdUfylStaNt1XmYQRJoa+/K0htHhowVYn+E
	ek8vGyhACjN6p43tN6bW0a7xIvmuvD/fDCxlXUYZCx6YDJPI22hEetgbKmVfmEZKncst8C
	A6yWY18TTqQ5l0EDMfLIU6n+VQEEkig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699892304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqBpMF6+W/H/NdkcPSZDiyEXyNi38LQ4S3FcnkyXMPc=;
	b=gbkTgnY52fO4dy6MNJTH2eV55muBAkr/LmaF6lJo7nxH2gfekJ6+8YN7LaWv98ZDgZRe6o
	Hud60Pd6MHCFK9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE79913398;
	Mon, 13 Nov 2023 16:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xjPyNVBMUmWTZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 13 Nov 2023 16:18:24 +0000
Date: Mon, 13 Nov 2023 17:20:20 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagern@suse.de>
Subject: Re: [PATCH blktests 0/2] nvme: Allow for pre-defined UUID and
 subsystem NQN
Message-ID: <6nhppt4vvmiqxejfn52blczirkzz6jkkd7knhqjqyhzmjinlkh@4jwzljveqajj>
References: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>

On Wed, Nov 08, 2023 at 03:47:51PM +0900, Shin'ichiro Kawasaki wrote:
> In the discussion to run nvme test group with real RDMA hardware, Hannes pointed
> out that pre-defined UUID and subsystem NQN will be obstacles. To address them,
> he created two patches in a PR [1]. I post the patches here for review by linux-
> nvme and linux-block members.
> 
> [1] https://github.com/osandov/blktests/pull/127
> 
> Hannes Reinecke (2):
>   nvme: do not print UUID to log files
>   nvme: do not print subsystem NQN to stdout

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
