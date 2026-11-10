Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323278;
	b=klxllJ8AUZo8kCGavVQ8NvaJf2FYoOLoBKnfoXykgjgY6gdhN2BFNQnfjOt16aplMteK
	 AvVoWQ0tyE/X/ZqA1Hr4rYyBAyAry3ccYTt1Hpj1XKpJ70Kw3GQAyTh0bUf78qJ0j2PFS
	 C7itfK5Tvbg715mjRp0mbkSDa2G3/MJQHWN85vJ4GaM8Rj9E/QnsRuCY6o8Jf8Ts0US2g
	 Jvn6IiOtC67iZGEm4J1Kim9jnA8OgtjAjRIbaK2kjbzCjJuZieZSEXN3Xur+6aE9aQE4z
	 lAD68eh0m7ZAeebQbN7z0f5wPcjuUPeh/wPEqCzG92tH9+/8qP+Aqgd67zImvlh6C3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
	b=BjY9Shz9xtqJ4Al6OsvBJwYNUQOoLyu/FGHlQmaXzoZdfh4I/YHuK8u49Dj55MSICKoR
	 uTkzi/CWJumNihvAnb/3McejoUAh8gURulJuuYXGD2enR6oRll+wAs9NuwNSF8GwgfKW9
	 ouJ98XSRhIOsaAXo0XYPd8+riz6no+ZeBIHxYzNoWhQ9y0MjtYJeuugTF8xZ9pUux4yWS
	 zifEWzz1UnvAAcH2iQwMJjyzxlGUrROpCsCu3U+c0L0643Qt/jEySE9wlcKKNwUHa9MF0
	 6+45QAbLp1KFQBY7Fyi/upu+py/+C3iZQAC2ex6VJSFsmErvfchpoBqtJrwFx9EMewA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB160A2626
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27AB160A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e977109392so12284635ad.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=LHozpx7ZkQyIUBsAkv4C311vzxfheFN2pzrL9Y/FTHkEXQzaVUkMAz9U9wFUejAOr8
         YATASi40x9WcOvyF4dkS6SJQ2bBJHO0yE68WsOT8oewufPXMhMYT6O7d4/5H33a+EMHR
         jjCu1KqktdAA/9c8ZIpbjFjA/3BLyNbgEZc3fS3F9+PTZ5y3jCgkJQ9rhGft5ONP+cJO
         aTEF5vn9sQP8UWqDXO8UszNcV0yZFTKvtrsUk25y1Sz/3h5njQt9uj1PBQLO+FuWPgpB
         LsGoLTWDE/iFYFuKD+GJLya2PXFipxPXM8zYDthkWkjgd0549O004Xgoom3qc/ylK84T
         vykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=byZ2zs9rTnxaJj7yefiFZwoIYhcTVzQX5HAn6ZiLpB+d2KS+GFYKdRLyvFbOGXNyyJ
         ohwtVq2bu2TEUjxMNUxDYvayVhhRvKpsS6sZsMBwE/fytUpcsmfCCtBUYniHw0Krj15g
         wAiwrm6XCwSfNNJBcV5lJ8DLSu4AmEHBvScERREViuIbkpZWkOVB4n1DXajrrlQ2qbve
         48WQEKBRibdrBc5fpsQSD6EGrXxY932xWDqHxt1+4C8/Lu6zmHH+28KGlh8zbRZK85LV
         4gyKn0Nw6PFVueGyN1bK3ED9wC9+t7aI8aezoeJurl1o1W/tyr3UIzbk6pCqFn4Za3Ar
         iCkQ==
X-Forwarded-Encrypted: i=1; AL+hErE2FVJ4P11scCjZqsBi0G/E2reT9h6eY3yv6aN8WzUHH5kxKuSyaATq9KAqzzf8CfU3zcDwr6JuAFiDPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dH/eQY4Bl4JWOvYD3YWmJk8Tk9z75Vx+knAXMHVVFnpSK+yxP
	q3ZYk1goGcU8wxSYht3un/9EkCmZaRxSrX6imKfh0jarxAJ7qomwXWeX
X-Gm-Gg: AYBFou1cFjSQHwfnFINu8q1iAwPQv4H0/cmuZTporATk49sNKdkOBF+DvFyGBLTRW+4
	zB/jo2dc5nNaqUKk8QIOO6fiwumqbOW6Zm+WmeCs8XsGYSETmlbV1Rg7ryZtCTN1mutlS8v4Q5S
	ZmtkDKQoiIgZp1veEDRdlqmdolWti63tLxXlAb3emEdoylGUxQkjLpN7qLWtlhJhL1c5EzTYk2q
	to1m5VANrY4bzdgyFAE31GHboowQdHH5FCi096KVX7W1dcwxNDqS+E2nqe6iArWBTwbPscGrQcz
	7i5+pvvSfvGZoV/IFEAR5M3bZdGCmPoKPhZEafWKqNcy71iQTndFMkMp38Tj0Pftbag/dqIkp7b
	yEgeBii9Rf+IV0rQLpt6g3wbMUdOI5/58lQtoNOr52EiTdEXfJvkYSQBscuTo4py4DiZCkLQX1w
	v1YliCjQjbls2Dcqq6C2b5xdUjSEPbf41C5eMfql0rZc4r1WRO7KP9kemu5qQnc63jsKC0LZGM2
	6cPKWAqZjrjkAUW8WiUEwVJKRUP+L9kv1ja3mNlGBbWwi1H7KkqgH2O5sagiewrvcxcT4DTlYAw
	x5NCR+RBYbUme9BV4aZrf4uyuwB5z0T+CFE/YVWQG5VhSocgOiaI85vpJujugTY6XGe/52Va2+1
	NRQLAQz4zRZI=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.
