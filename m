Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913163;
	b=S7v/XkLnsLo1CHzzVpKJI0xM4577eVCHVh3fpuQxzWNCt3Kzd8sdT1nZeHFnodVjNSTy
	 MbB1kGA09EFGi9mkJ+jiLp7fabNNFXJBuzZrr6kEzWJOftby5sZ5YKU9XZDKlqXxdxFgx
	 LhVNvQlaNEkSyAtFd/SSWFlGWdNZXVe8+Kw4k5ikudaYGS7MUrm2pSPnMUCEAC/kh0bFM
	 dtjyc7jzZwfeUSDrqKgKM5BtRAK5G7wtgSL27jHlLeT823NQFqJ6vt2xb3OE1wJh2AG8S
	 4Sn/HS4me60zjDadrk8zv6UzfeE7NOGLChHa93EIAkg89St4HyuJdeBpOrJgU/5paEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=AWPCuPoHCv+Zra6hIa4YWB5+e+mvMzbV0T9yKI8SxJ8=;
	b=kgO4+3jp6gsiI7FHY3ZF8LjfrUR5B9rCGuag9r8ygmrUGm2fw1CHopA0iZunAI22QUGU
	 6UeiMm656RKSP+jb71czFAJenbQXqxPCJjRAsM/Gl5is9db5qZDQLXahyc/niTYz8HHue
	 ScTY92Hp2Mpdlg2jYEXtnCm6+ga/maeedBFWKWXrsPeEoCw6kVepriMlsEnxncGezVuQi
	 R3Ec0AgrQ3m8wEe8OxETkgvQ3iaNNxFyNEFTZktfdjr38SCS2JyDsvWlXg4bA7PLfPkWP
	 Qj2q0DTN8RUtnZbPVYgehu7kux2+crewYea03ZegCYOG67/EkWLHv4YAY3w/hCLnajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNPcZPEE;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E408606A323
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 10:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E408606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNPcZPEE
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36dc4797082so507137eec.2
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 02:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913162; x=1795517962; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AWPCuPoHCv+Zra6hIa4YWB5+e+mvMzbV0T9yKI8SxJ8=;
        b=UNPcZPEEsn37iNzR5BHZ42Sr3tN4VZ9Lv2Yif3EENPgZaFaLs9tqDqtEEfq53TCXCe
         3m3KoyPcPsFm2QS3KoRArF3/pTCgbHxxTXnz6NJCLtzMLAtPKFravgmUpDDnKnDaemaL
         rZhoovzvspQB9lZgRcEne0yltohXjMT88z+Q8x1eGjmN5a8mFTxw7/38YpMmPdERoiPw
         DYvbjN7Z8f+aZ4e1hsViJkjXib+XMWch8pjQYlKWAZn6A/Ne6iF6cAes/BilS+4w7EpK
         bckXAnSJJ5JlKj3fo8x1LofNXVGHguylqhbdmjHTGEVPS4RUbyqx+dq9msjuNiV7IzwT
         9a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913162; x=1795517962;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWPCuPoHCv+Zra6hIa4YWB5+e+mvMzbV0T9yKI8SxJ8=;
        b=iNWmSOuwW8eoTwXhAOFVfbz+ReS95Tx9fcMLM1kwfGYSDk3lj9Z3JivXrDReEs9qGb
         feckf/OOXdIWsnsPM/HIdOCuDpeNgQF73MW2vCaJpqKE8MGeO8Z2bqCMZRCMKFG2GFM2
         hY6OuKfjkuIGqNxS4SIqZ2x2gwpATumvfT+iqgEdinvlhogN3dCsZ3Mj8D7iNbWJiS7E
         LH/aZQDTPTKOW/icx99Q8xEptEh4oM6/tNAP9Juu2HUkNF9WVB5sW5Apbiu4rgeVXp7l
         L8JvM7vK4t/o++dKlbJ1hnWE5FFxWAfZNmFOVCmeT2qGNfB3BHd6KvWw+84xN8q59QUA
         pugQ==
X-Forwarded-Encrypted: i=1; AL+hErHMLqFrk1NiSwoom58l0dvFbM44qxgen9ZZG6UvNiKdnj0CgZW8BJ2axELsF9lAeFEbppzMOATdxsQK0A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hG+V+PRpQOpIowtyIOZJptZX9ij6iyfaUP9Y9Vd4ew+moxHSg
	peW9NFLZvkAdv7qpzoiPLfLqfzIT+yroY24IB+qkqoxiED08wXww1qoZ
X-Gm-Gg: AZFdTZcYSUJMjb8S6Z+9JPgPqRbX73fm2h5WR8z7aoW6PXEc2zBKhgQN20+GcWGQDSB
	DwoDmcHm/KnIeLFfe4ZNOoizKvg2hAZlVSZIuVLb0kumM0S9ynR/bivURMVfOHykhhaGTi+QX7i
	4AUuuYabioFEfGSIYXdr1FXwB6SdP9aoP3mfD458rtx3iWSo9saUBCOlpv36tnyPqIx9Ahq4Jfv
	17iLQS/4kZxV5w6YFJZd+kjy4/SohklDIyl0ie1X9AO4dS/seg/5HgtLOFEEjuhh+KPn5+JFlH2
	QIq6cqoK52i8FoK5okarsZjrS8SG96rYIQj3cnxquuecoAeldSgUBhoppbRmhMhvUF+VbXwCJoL
	xt06KkSlaE2EgW9YVVKe7pid2kLNYE3qZ3A/0d0X26cqkfUVKu3s+StBVOrCJyJpYa2lYcxv1+C
	4WeGKtfpvv4BKo7yBXsTIOZ6HK4AHopKe0M3SB0JgR92L+KnM+i39/fxHgOecE6FOdv+7ApzgWi
	CtTiABWVCzpdUgEDwl0QDMPqYBh9/DwFh5oDbnfiv6AjrtKSZF7DbC0igye5YJVUsekaZHlFG7Y
	LIwhWz/3nOR0wP1stltS0qCcHnIaBGn6+e9e9heA1OjhuyCQzx0HThog5ipjx6p0BdY=
X-Received: by 2002:a05:693c:895c:10b0:381:6297:8f99 with SMTP id 5a478bee46e88-3816297a694mr2315523eec.2.1794913161810;
        Tue, 17 Nov 2026 02:59:21 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm44832996eec.28.2026.11.17.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:59:21 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/11] zsmalloc: embed struct zs_handle into zram
 and zswap entries
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
 Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, Yosry Ahmed <yosry@kernel.org>
In-Reply-To: <20261111064707.2568433-10-senozhatsky@chromium.org>
References: <20261111064707.2568433-1-senozhatsky@chromium.org>
 <20261111064707.2568433-10-senozhatsky@chromium.org>
Date: Tue, 17 Nov 2026 18:59:13 +0800
Message-Id: <179491315345.964041.6401768578977065454.b4-review@b4>
X-Mailer: b4 0.16.0

On Wed, 11 Nov 2026 15:46:32 +0900, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> zsmalloc allocates an object from handle_cachep for every stored
> object, just to have a stable address which compaction and page
> migration can update when the object moves.  Both zram and zswap
> already have per-entry structures that hold the handle, so we basically
> keep a pointer to a pointer, which costs 8 bytes per stored object,
> slab alloc/free on every store and free, and one more memory load on
> every access.
> 
> [...]

Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

-- 
Best regards,
Xueyuan

