Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90A154435;
	Mon, 29 Jan 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542819; cv=none; b=UJQ3xeTJKcCKYEw64Y0mAE3r1naHY8tEPLmjzGo3bgOs18UF7BrW+pyFHk3vrGI5STD6oCcBH65jxVf4khz5YYIWBrqZScCW1sqLj4O/eqVjwhX27lcG8l2uFX5hoh2VoOfwSuOukmRlGIaG193T+kFvQTR90wgGJ3C7zYuO1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542819; c=relaxed/simple;
	bh=ocp9wrIiOV3UxfROtr4WSZIo3dfsyLIKLudXCEgM2BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9Vd1Z6uVsWMi2SB3FkiiVNGGYNdXBm9bJsllHdC5uOdcMV+TPunkEWayAxMhS8XI2ft4j3OI5OoKBbeQHixj+gOZ8ks5jLanEdinnVb1EcMyI/B0JS7dfFWo2pdEx9LZIu0ltTg/vPeNpTpiv0cDC3nRP+fOQ5hRZ7RrBu4W1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HbDN2ocd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eMf7VhOs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HbDN2ocd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eMf7VhOs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HbDN2ocd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eMf7VhOs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HbDN2ocd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eMf7VhOs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C5AE1F7EF;
	Mon, 29 Jan 2024 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706542816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBEMBYC+4+1M6M1DFshRggxJ1Y32L99wtqqXZej63gQ=;
	b=HbDN2ocdunm7sTSaM2rCBwcwhgrvgIGTziAa+KoGRcRges0xPjakjKhKRDGUex7DGjkHGl
	NREfYIB9TTiUU2WLvzilAt6Q3lltRyA6pF6kESiNv2tJh2HNPxJOEgresY37y1ZTABnl0T
	PzMiFLY4cL7IepRix+NxWmhvbKIfIsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706542816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBEMBYC+4+1M6M1DFshRggxJ1Y32L99wtqqXZej63gQ=;
	b=eMf7VhOsawtI6qs9minZNTUwba8rACB8Uv2OCoBN+KB1TEotE0VVZ0/74262y1Yfh2zIW3
	Z/+DLfLy05at57Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706542816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBEMBYC+4+1M6M1DFshRggxJ1Y32L99wtqqXZej63gQ=;
	b=HbDN2ocdunm7sTSaM2rCBwcwhgrvgIGTziAa+KoGRcRges0xPjakjKhKRDGUex7DGjkHGl
	NREfYIB9TTiUU2WLvzilAt6Q3lltRyA6pF6kESiNv2tJh2HNPxJOEgresY37y1ZTABnl0T
	PzMiFLY4cL7IepRix+NxWmhvbKIfIsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706542816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBEMBYC+4+1M6M1DFshRggxJ1Y32L99wtqqXZej63gQ=;
	b=eMf7VhOsawtI6qs9minZNTUwba8rACB8Uv2OCoBN+KB1TEotE0VVZ0/74262y1Yfh2zIW3
	Z/+DLfLy05at57Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EF2313647;
	Mon, 29 Jan 2024 15:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8bY7HN/Gt2X+RwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 29 Jan 2024 15:40:15 +0000
Message-ID: <c7231bc2-37a1-43c6-b388-1005f299e584@suse.de>
Date: Mon, 29 Jan 2024 16:40:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Rust block device driver APIs
Content-Language: en-US
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
 lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Damien Le Moal <dlemoal@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 gost.dev@samsung.com
References: <87v87cgsp8.fsf@metaspace.dk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <87v87cgsp8.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLku6r1htwf7q1rn8ejdiurxd1)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kernel.dk,kernel.org,infradead.org,suse.de,lst.de,gmail.com,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 1/29/24 14:17, Andreas Hindborg (Samsung) wrote:
> Hi All,
> 
> I would like to propose a session on the Rust block device driver APIs.
> 
> I submitted the APIs along with a simple null block driver as an RFC last year
> [1]. Since then I have kept the code in sync with latest mainline release [2],
> cleaned up the code, and added a few features.
> 
> After talking to some of you at various meetups over the past year, I think we
> have reached a point where we can potentially agree on merging initial Rust
> block layer support, along with the null block driver. To that end, I plan to
> send a few iterations of the patch set before LSF in May, so that we can use the
> session to discuss any remaining details.
> 
> Since Kent has also proposed a dedicated Rust session, we might find some
> synergy with this topic [3].
> 
> I also maintain an NVMe driver based on the Rust block APIs [4]. Due to
> community feedback, I have no plans for upstreaming this driver at the moment.
> However, it is a valuable tool for designing a sensible Rust block device API
> that is suitable real hardware.
> 
> Part of the NVMe patches are abstractions for PCI. Other users (drm) have
> expressed interest in these, so I plan to separate these in their own tree to
> make them easier to pick up for those users.
> 
> As a last note, I have recently become aware of ongoing work on
> implementing nbd in Rust. The work looks promising, and I hope the
> author will decide to send the patches, when they are ready to be
> shared.
> 
And I had an intern converting nbd to rust, which I could present as a 
proof-of-concept.
Or, rather, as a showcase how a (pretty basic) Rust driver would look 
like. Idea is to have a side-by-side comparison and figure out if
a) writing driver in Rust would simplify the code
b) existing/requiring functionality can be matched
or, in short, if Rust lives up to its promises.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

