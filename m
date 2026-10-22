Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713117;
	b=ZrH3BhYHUz8MNCc5xWCgowZHqlTxMS34ILVTWbeQ1JKouavArzMy0PL4572IzBt5uVLL
	 Cv2PfeeX6W/0tY4CXT1aOrciQdvk22bEGy1Gr0j9OZT2p+QLqWkrmhbNdlVmtWj4ktNQ2
	 pmUVRDypSJQCZJtfRLmNJGuSClmBMus60Zck3BzyQI8UXjM2DPoQIBOkoJBcOCWYKsENA
	 b1Jlpiwxw/QbCtp5HpI11s0MZMUh3cgLhkyCqrpUSou39/irgsRzLGD5eRL9AM+UNUY0y
	 DNzYpsxYvfy+ARSdU49Hq+iSL4nuxNtwpR3sBalD/mvDAfapVuLOd0HGJ7Rg4EWz4Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=gqwUKq+SQbEEXMaOitIcffWM6vbj1qymXwiYLf985+Q=;
	b=X/bwqjvKBS97cmCFpCW3hG/pES+v9I2oHJ/NPlSM12gZBgVi3y7kehS5/e1m1Axi4JY9
	 +9rko3XenjIUqraYsn5euB/6gj8gNAinDiD8AuevQVHVHz+wwr2twcKEMysynFMZvOSz5
	 sLrFdxno+qwsaxKpk9DN+qAPTOgSfqACBHPwdhrOBGW2Bj/Vp9rRcC4pIHkN0FBEXw6M6
	 tD+/Dri7umjFoEW3gO4Y1yfs8v2mH7erFd4LsYGoYqcFOI1yvtRaWav+IJrXNofKIWIYo
	 doXUQmTKCb+burbwq2TdWXnRiVTfidJB0wgEeJqq/jS4peZb1x4hKU1DkkySSMtgESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dilger.ca;
	spf=pass smtp.mailfrom=dilger.ca;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDB606A31E
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 23:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBDB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so134685a12.0
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1792713109; x=1793317909; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gqwUKq+SQbEEXMaOitIcffWM6vbj1qymXwiYLf985+Q=;
        b=P1bPMEgREGhmxP/g/CEHjUAjIs8MHA4kGQc2dxe6T2f3Y72wenVgP8JFneWvTvLFwn
         ZKUYp+4ytRzTNfk0T9wDs21qhWm5oIV2Jf1oM9Rc5XfvolX00Oh6YLo4fgAnXH6ITL5N
         U9+T6GRJfMe9+4j7VLUHsU6mfL7fYX/D3eeOMnxfyK/8tvLIp0ghOKUCY9hLoBqUwr1R
         pdAty9V12zbNzsytcWjb3yWl3S7AIvIyhMPrq4/ngBqUpLBQhd9d2sitkuvtiP640Elo
         FT80vhtZCGxOHW3yWnCzv3nzSfc9NYWz7Cmi9mDtzuxNaGdEgLjtKiKYmhHJ+LjdFvuy
         3yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792713109; x=1793317909;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqwUKq+SQbEEXMaOitIcffWM6vbj1qymXwiYLf985+Q=;
        b=y4lTc54TqytP5gCCkFwCalV5b0OC54oDJUeYp6xfXcadCsH5fA/pHGsBPharNw2OCu
         7b/x85lwop4bCErNZ1moj9Mb7qbpfcU5qy9daCBu8D4YvoSHvGCa7is6m6X7KELnwZcp
         GTUI87FhUv72o9ewEGqkhT65NdW9+AkDDB3ydGiruiBQu20bsv39wp6wxSaE2u8DUNi0
         jPc4hPDneiGE1FQu/GdGcHLpgP33yzyt3TeJX2ZMVV/TK9ZohLcLbvRmoYOznODO4TRW
         UwJjOeYRMjNpyTz3mvlCdFG2qUPfiPpLKt+R7Ydm3qw0xHvx7NQn8S+Nqro3C/1ZZaq3
         33uQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3bBCEnguuAJUjVWFNlbAyJNwZwrJFNXm+ooGpGCdDhYQfy0o57P0PyW/gPnCPdunUtbKS4wV5eAJvdw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIXcmoTA7BugvvDElPgrYi/FkGtxbKhswOk414+n8PMGY5u1O5t
	iAMvjBg/PmTQD/DoZgXbqeoP/NnDHRTJbX2VeGUISqrGIfqXAdCTgiuu7kA4aTWDczo=
X-Gm-Gg: AYBFou3VWhnA1CSG1ShPN82UAukmnvZRNN87164RgIEpEN4moBKHmmrBD7xfWfTl/R7
	SMhN565hTkRN920qXWyHVx3L9QKCq6Kn8EfDsDyq+awZEqUO+du1gbV+OL+F7n/7EkMp9Pp7lpF
	bSRa9dqQ3pKV43frbx7jUc+QZJcVOX7GzDti+sIbUv5WWxJ9rQKx90aPBubATvLL/0nMIr87elC
	w1k8qIic7FAurIi/oQxN8CxwDe4R/VaQ2jmlZvaGlVXZBbTJ9fOx1+DyLNJs1lo2CgOvxjRz9tO
	7kZ8QqrysdthwhbNA2TyNh0V6SbxlBwzsjiUsSE0BXBIevEKo59sg11AfLZ2izpxR3OvbhNJxku
	MmdPPsHncC30WfXRm7EzUZ58i5COBm+gSgEIeAdENjpzLM9Q/2XystHCAIantymcfx8Nyv4vVYx
	FqTBAc04iGBJHNszyE55Q/lVc+X0WryhtejAirvyTkUTB2nw+UEqYItmTphKgIvjH6lSHWZiKXU
	+M4rllDxw4A25gnv3cfr4/N894kjgsdGUtTNbF60aBvx5JzBfLPSLgjWLwPq5QvEW7JWtx5o5g1
	vj4gdDJhGvwtsO0=
X-Received: by 2002:a17:90b:1c0e:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3adce4a5020mr298916a91.59.1792713108702;
        Thu, 22 Oct 2026 16:51:48 -0700 (PDT)
Received: from smtpclient.apple ([199.7.158.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890c56sm6439266a91.2.2026.10.22.16.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 16:51:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH 00/13] block, ext4: allow encryption with a block size
 larger than the page size
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20261022220454.GC1383716@google.com>
Date: Thu, 22 Oct 2026 17:51:30 -0600
Cc: Baokun Li <libaokun@linux.alibaba.com>,
 linux-ext4@vger.kernel.org,
 linux-fscrypt@vger.kernel.org,
 linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org,
 jaegeuk@kernel.org,
 axboe@kernel.dk,
 hch@lst.de,
 djwong@kernel.org,
 brauner@kernel.org,
 tytso@mit.edu,
 berto@igalia.com,
 jack@suse.cz,
 yi.zhang@huawei.com,
 ojaswin@linux.ibm.com,
 ritesh.list@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4A31F65-8CED-40AB-9C5A-68ADE6A9BDE0@dilger.ca>
References: <20261011170958.1759230-1-libaokun@linux.alibaba.com>
 <20261015185325.GG2170687@google.com>
 <625e5190-d43e-4a2b-9296-da15c52d1a9a@linux.alibaba.com>
 <20261022220454.GC1383716@google.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3864.700.51.1.3)

On Oct 22, 2026, at 16:04, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> On Fri, Oct 23, 2026 at 12:30:39AM +0800, Baokun Li wrote:
>> Hi Eric, Thank you for your feedback!
>> On 2026/10/16 02:53, Eric Biggers wrote:
>>> On Mon, Oct 12, 2026 at 01:09:45AM +0800, Baokun Li wrote:
>>>> Motivation
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>=20
>>>> ext4 supports a block size larger than the page size (LBS), e.g. a =
32k
>>>> block size on a machine with 4k pages [1].  Encryption, however, is
>>>> still refused on such a filesystem: file contents used to be =
encrypted
>>>> page by page in the fs-layer path, which cannot handle a folio that
>>>> covers several data units, so the checks that refuse encryption =
with
>>>> such a block size stayed in place.
>>>>=20
>>>> Since commit 5acc6f649a68 ("fscrypt: Always use blk-crypto for
>>>> contents on block-based filesystems") file contents are always
>>>> encrypted through blk-crypto.  Inline encryption hardware can =
already
>>>> en/decrypt a data unit that spans several pages, but the fallback =
and
>>>> the block layer cannot carry such a data unit:
>>>>=20
>>>>  1. blk-crypto-fallback en/decrypts a data unit with the bio_vecs =
of
>>>>     a single page-clamped segment, so a larger data unit fails with
>>>>     BLK_STS_INVAL;
>>>>  2. the block layer requires every bio_vec of an encrypted bio to =
be
>>>>     data unit aligned, and splits such a bio without rounding the
>>>>     split size down to the data unit size;
>>>>  3. iomap cuts the direct I/O bios of an encrypted file only at the
>>>>     logical block size of the device, so a bio can end in the =
middle
>>>>     of a data unit.
>>>>=20
>>>> This series adds the missing pieces on all three layers, removes =
the
>>>> refusals, and enables large folios for encrypted files on the way.
>>>>=20
>>>> [1]: =
https://lore.kernel.org/all/20251121090654.631996-1-libaokun@huaweicloud.c=
om
>>> A high-level question: most of the complexity in this series is to
>>> support crypto_data_unit_size > PAGE_SIZE, despite the actual goal =
being
>>> to support fs_block_size > PAGE_SIZE.  It's left unstated that the
>>> default of crypto_data_unit_size =3D=3D fs_block_size is used.  =
However,
>>> ext4 and f2fs already support crypto_data_unit_size < fs_block_size.
>>>=20
>>> Would leaving the crypto_data_unit_size at e.g. 4 KiB while =
increasing
>>> fs_block_size be a simpler way to achieve the goal of this series?
>>=20
>> I initially followed the LBS approach of lifting the page-size
>> restriction, keeping the existing default crypto_data_unit_size
>> equal to fs_block_size. I had not considered using sub-block DUs.
>>=20
>> After your reply, I implemented a variant using min(bs, PS) for
>> new default v2 policies, recording a smaller DU explicitly on disk.
>> This avoids patches 3-6 and the per-bvec alignment relaxation in
>> patch 10, and is indeed much simpler.
>>=20
>> Both variants retain large-folio support and showed similar gains,
>> about twice their respective 4K-block controls. Although 32K DUs =
reduced
>> decryption calls eightfold, I did not observe a consistent additional
>> throughput benefit, or CPU savings at matched bandwidth, in the =
tested
>> workloads.
>>=20
>>> Or do you feel that would be incomplete, and you'd indeed like to
>>> support crypto_data_unit_size =3D fs_block_size > PAGE_SIZE?
>>=20
>> However, keeping DU =3D bs has a compatibility advantage for existing
>> encrypted filesystems.
>>=20
>> For example, a 64K-block filesystem created with a default v2 policy
>> on a 64K-page machine uses 64K DUs. Supporting DU > PAGE_SIZE would
>> allow a 4K-page machine to use that format without re-encryption,
>> assuming the other policy and backend requirements are met.
>>=20
>> This also covers otherwise-supported legacy v1 policies, which cannot
>> encode smaller DUs.
>>=20
>> Explicit 4K v2 DUs can also be portable across page sizes, but
>> choosing a smaller DU for new files does not make existing large-DU
>> ciphertext readable on a smaller-page machine. I have not yet tested
>> the cross-page-size migration.
>>=20
>> If you think supporting DU =3D bs > PS makes this series too broad,
>> I can use the simpler sub-block version in the next revision and
>> develop larger-DU support separately.
>>=20
>> Looking forward to hearing your thoughts.
>=20
> I think I prefer the simpler version for now.  If someone wants to
> create encrypted files on a 64K block size filesystem on a 64K =
PAGE_SIZE
> system that are also readable on a 4K PAGE_SIZE system, for now they =
can
> just set crypto_data_unit_size =3D 4K.  v1 policies were deprecated 7
> years ago, so they shouldn't really factor into considerations here.
>=20
> Note also that setting crypto_data_unit_size too high can break write
> atomicity as well as compatibility with inline encryption hardware.
>=20
> (Also, the more common use case these days is that someone is
> *increasing* their page size, not decreasing it.)
>=20
> I understand there's been a trend to lift limitations like these and
> make every size work on every system.  But the large crypto data unit
> sizes are difficult to implement correctly, and the proposed
> implementation slows down common cases that matter.  Let's focus on
> fs_block_size > PAGE_SIZE by itself first.

For Lustre fscrypt we just *always* use 4096-byte fscrypt blocks.

That ensures that x86 and aarch64-64k (or other) clients can read
and write fscrypt files in a compatible manner.  I don't _think_
there is any performance advantage to be had from doing fscrypt in
64k chunks, and this would also keep the ext4 filesystem compatible
between aarch64-64k and x86 clients in the (less common) case it is
mounted on a different host.

Cheers, Andreas





