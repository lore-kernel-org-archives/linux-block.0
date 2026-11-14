Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686757;
	b=iQWFOARW2k2+h+hbJepSVtidoARrzgS1haWCbzn6Vj2StIoa9VjNQxjhe1IxmVsA92iE
	 mrMG89ywkXRhlJt+LhW3Ye8S77RhRv+mKvftwusrq5bmMBY+D6gKZrUx9J4cJhYwtTZ7H
	 zU4/BhCmtYC1YMcXp1Nk0Bwq6O32mYPMFzcwD7CfvSgwVLfBUskL4DZY2UAn3TobG/Wsb
	 myTtgnbcTJennAVbaqI8Qsks9Jw5yQMJT/ogDRaEeAaLfM8cQTJsS9qV3kvUmFWX4F25N
	 s/BvD4cZWYRwAwZP0UXZts384lO05sRmqni4zKWpbSUPX9r7zipuJsggZEukxFzeg0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	b=fm3tj3Hq1H32U+f/VRY3e7XFcVGm08C03XE6nqBioz6bYDSUjdNYflWLQUTsDBvvrekv
	 eM2uVPYjFnmv0k0rHHL2eI7AAiIhmzKmpqS3+9x2CBdsaAiRsO2Eo6c1kfDtHOii9ZSUH
	 uqrPje7ORQ8Ptx31LLIerOiecACz6KogUvN5EeyaMjavwQ74OglrmU6wwQlzgICgPcYkF
	 wmELMgqu448qlL52bU3iXWn5mBkc6FGgA+AmU5oRXvkDuWWv3UQTbdxAhpUnCrJ5GDms0
	 FZYyyCuweDTgVQOVN55UG7NnMiKN4qEGFS15qVuW8pIGkDwJs+Jfe+64brby6qqu3JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A356A606A333
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A356A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1295175b3a.0
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=ZNpsvJMizOoFFuviUq3R3I7xBszXKHR6f+dU2Lhp8+AdJOsuucW/Jpjz4DKxOc01P8
         7Bf2gXYBYorSyL2ypHSps7l13uEx7uOW/BQ3oCjgyM7fn4nszFId/ZhifmOhhkUhMak/
         Krv6vg2ZKrT882kZ97nfZeCj+rR5WiJ1p/wW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=2olQpXkyHc8KENQZUsEu/soe9dHWfDYaGQ83V8OTbx5UE8VPFrkTFX+6Owgv2nSWF7
         FB13TYfkGCrY+G1FNAXBf2livf1XrIsDyFUtlRIVs52ut7zL+xU0okRp01PxaQrIczLO
         vA+XRdPd53IZbI3hjWmKASeDQrp6Z1w0e/XS7+9KNu3e3xfAWQWTrWOG6WXy3E9RzsiY
         kQv6lLsI1aqFB5YCArYL/UC6vXl8Ha5mjABLGll1WvF3k+XkgJftbXWkNyZ9GsHOJaQp
         kP4pHN3bqbvwc3ckm2KEOZvQQQDnB5Ja84PTkwQra5UrVpIVKPEJu0BbfJNTrQ+ah4Gk
         l2vA==
X-Forwarded-Encrypted: i=1; AL+hErHMH7TTLcWhNkLqZf4mtypEdZZYbBmkP3rQ6fHK36vXfbM6lPD8sO1ha6sbLzaLXzFd2TFsW2/g+GY5Tg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wTteg4bd+IEwFKfoP71r7NTKuvd8jh1w3aqVlNxkHv5B52nmz
	SSyQ3W2t519FvYUcWjjkDq66VubDVxaovxppuolN0ub7WZ5a9pBwjyQTYiPyNtRd7ZA=
X-Gm-Gg: AYBFou09E7oOOm+5EVrOY6dwJcou8UD7T/jE4yntJLeKUE1NV/Yhp9OfLjdzLgyO6tK
	uxmfBJgpFmLl1sVJ00X6nIYBw6mo9tMAVA/hT/hO3Fzut2Sf9ga84OYZOOPuHYpz2j2KVcD1vaE
	tlXwlp3/+NyZCw6t+Y2mdjYcI8tg+XwlINJzkD3pnms1/TtGaFcFFAOcLMDzNxnHeIVg20u1kba
	hoiXLWquLNAofvJxDndIKlkZ3JeuyWu/tiewPNZfxa6G/dukNkVBXGSyx98FBcTqKz2hkUNVSv6
	MHzEiYW18cXYE5CVQPO/GU2ifbWkdq7V30tVIMgGKd2tBVq+V+AxXc/BuNcumlM4nZDs9+JxFPZ
	/wfiCkybx+n63N0umxD0DCM6+hvm99K1pR70+o6SXhbLMGWgmD64ly08RVHpz6pLUZCD5gbLd2K
	fCcrIa52KnXG+mJs3cWg8/xbm6W6U8PGK4Ynjro7D3Gf1PVn6YI6/CJat6mNZia/2kV5NJKE5K1
	idgGrXPahEt5rx6/9Rces2Mu1dAERPyGCVweDkNdJnO9BNXM79Srql/Fg00t34Adg2tfGNVuz9P
	zdfjPfpXmK164Zy90U3QEkb47u3C88ihtUJwUywEdWEqXd4fEqyyOzVql+H1cT0rGRUdsfDwtE+
	eF/LFg/xq/GBIRoOm7gD7kitD+qgva5TPfz2AFPPLAcVGt+5VbwhvwQ6NJnhRbBrYydnpRZFqxa
	5+lltYDbQNK+qwwBvfH01Qe/qeAipUoUN7lpAS3L1HNn0/uLaCcN2Ta3JB
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris
