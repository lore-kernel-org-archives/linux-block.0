Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B845D73B
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218440; cv=none; b=iNKiVudhNloZCS8Na1R7+/26Cf52WyPKKMP+j8+50bJb1uj9iayBjeqjUq2joHULwWFiKM2MplRn4NiXP4QqvBlr1+RA1ZS5JmZuY3bKXa+RpnsnVW2FSu4VnYei6vUt7eXUmPz1GwymJrH0btYrfViAYiX4vSlZp0qCS3sTF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218440; c=relaxed/simple;
	bh=lUWQV3DVVCKaY36/s3GSXNK1shEn3P+61gS0tWGD4uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe8J8G7kzJKUZyn69Oz8+g4I7IT2J5ofibjOA/OU7qt3JF3eNHO5CRUjoJxv6+6AdgkS24R6vUEleBuWWTdK9XS4TJtHyDclFnxr7g7mpeRYXoqDdAzwvbaXpRg6QcMPk0zcem+wMxhCehSbv+PP2o8Hy5E/p/83Eu2JQMM41YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t7YE2bmO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oR4mWVqe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t7YE2bmO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oR4mWVqe"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDC573796B;
	Thu,  4 Apr 2024 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712218436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCIwQG6XMFwg5jqXsEKk4WeiCNj9G5QjfJ1ybiVgzWQ=;
	b=t7YE2bmOmn/Cz+kFK7qjRVwVkI5mIPKAHORbyrWKumzoN58Td744rJV3byoqq4WR2vzah9
	bvjVwo4O4ADiI4zgHl8WoV6VSicpLqM3D7bp88552HHQJzdJ10QQvabaIlEPVAlkbRP+a4
	g6FoeXguHpul67y7YYBH+6zmiO2qa3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712218436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCIwQG6XMFwg5jqXsEKk4WeiCNj9G5QjfJ1ybiVgzWQ=;
	b=oR4mWVqe0WP/pXIf5FAEFu5FXQCEWbybMDx3HB0Qdx4X95rJ/Le6B+0vaScDbhrw1eTMSo
	61IY5ocrlxaS4rDw==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DBFD113298;
	Thu,  4 Apr 2024 08:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id atZCNERhDmatCgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 08:13:56 +0000
Date: Thu, 4 Apr 2024 10:13:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Message-ID: <t5ad3v5sym5ccj7tptsguclhxywug6rvmn3j2li7gdkmhfw665@ikp3kgcrb5ah>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
 <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
 <5aa4ebdd-5800-4701-9a80-c737b2760ec8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa4ebdd-5800-4701-9a80-c737b2760ec8@nvidia.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Apr 03, 2024 at 10:27:48PM +0000, Chaitanya Kulkarni wrote:
> reducing code is always encouraged, but please don't change the test
> coverage and

This series increases the test coverage.

> make user add additional steps to run the tests, IOW ./check nvme should 
> run all
> the tests case by default as it dose today, this will keep your changes 
> backward
> compatible ..

Well, that is not really true right now. E.g. nvme_trtype is loop by
default. And you need to specify the additional transports manually.

This is also why I suggest we think about some sort of generic way to do
this types of 'matrix configuration'(*) out of the box.

(* don't know how to name this better)
