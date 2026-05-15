Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A293F44DE
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884209; cv=none; b=p/g/tT13MfdqbumK9EzMr3NTUHg5sflGfgSx4SVI3QzzGtTxQTiNZgtg6OsRyts4JYEsw69SDlBLmvjZWrUSU05NEUEa4+g/1xvrybcHUKwkwyeBBeSYOB4b0x4n/hNJx711l2tOybIYypnzvPom4KGc9qDQCnrysE6D2PXmMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884209; c=relaxed/simple;
	bh=ReQtRGN6YCVCM+VLe1SVEp6J++lmzI2ST6cnJuKfsNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvlHGU9FujJwUr6tsxTd6zftaHSPjsCUimEPDZBL7Im1tMc06LdMd4+6lkbbcSR8gXFqS2jVmRfJbaj5JmTS+W6hEfyFPdaPg61EgJsE4xDbKaOTMJOLkvFFsQLgoCpyZinaIYCJqbdEBPGTwPI3xxIhY03hLC10w3yhBDwZa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1BmAcRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1BmAcRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93BAC4AF09
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778884208;
	bh=ReQtRGN6YCVCM+VLe1SVEp6J++lmzI2ST6cnJuKfsNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l1BmAcRSlMtkGR8AS0UI7PMBSsVdeQ+vAfkS1phC7SdTdRHX+BGs4MAQg6DgBmiXA
	 d+XKcoVCgyus/I8MJO2S5377iU9wMxI4ndzUMSOH3X0aA5wcic6o9RuVDF3YmW+Cyd
	 Rsm0oXBAm3I4KOJJf2LhQe4ro/ZXtPTXTgkhYGdTF1JpalHy6mrdtRIOikrONxR6gi
	 khlgGqooS0g8AnPRBVazaVmq7yYCJ19qdANfoofjF9OShgb9otGvgrG9SRWnjQPRsF
	 l52n9H+vH0yBViDvJWLpYnNjBc23ogiZTPw0OfmtteiSRyxOR0C1GXSFcVk7sCYfIz
	 GNPD2LtwC5Ozg==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c24be9e4bso660138d50.1
        for <linux-block@vger.kernel.org>; Fri, 15 May 2026 15:30:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/w5NkDCcNsZEzGefouwzimh57TtROJ7f+wduF8pWPeCrO+qU+PaooZgpKE/cLqupfabWb2EKBtRi+mLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YziZaV5tDjGt/6YjnwDb7xv/qjgw3k52QVwu+SWCK2CxvtqtHwV
	UIjlxqHFijkh39F3ae5Lj08L40cspWyhSpwit7w6ztY2og76quiq1EkthMz94R5Ku6ULtX2nRiQ
	zxkiyT4DjGcUc8jbSXgWRxoJWcNo78nYAF5f1n7WpoA==
X-Received: by 2002:a05:690e:480f:b0:64e:597a:f5c2 with SMTP id
 956f58d0204a3-65e2289a39cmr4822587d50.65.1778884208163; Fri, 15 May 2026
 15:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de> <20260512053625.2950900-3-hch@lst.de>
In-Reply-To: <20260512053625.2950900-3-hch@lst.de>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 May 2026 15:29:57 -0700
X-Gmail-Original-Message-ID: <CACePvbUPQ=tO5feC=2-8XdBV1PgzoX+EwASU__jNiuzcGsPMPA@mail.gmail.com>
X-Gm-Features: AVHnY4KVT3GwVUdlKXUpf18PwWGpkgh1B7IPlKLHiB6TxVcw3NQNEM73-FjKVDw
Message-ID: <CACePvbUPQ=tO5feC=2-8XdBV1PgzoX+EwASU__jNiuzcGsPMPA@mail.gmail.com>
Subject: Re: [PATCH 02/12] swap: move boilerplate code into the core swap code
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:36=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Make the core swap code calculate sis->pages, nr_extents and the span,
> re-set sis->max based on it and don't require passing the current offset
> into the swap file to swap_add_extent as all that can trivially be
> calculated internally.  Also truncate the spans based on the available
> information.
>
> All this removes a lot of boilerplate code in the callers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Very nice cleanup.

Acked-by: Chris Li <chrisl@kernel.org>

Chris
