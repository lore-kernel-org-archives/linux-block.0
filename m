Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255136165E
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066299; cv=pass; b=jHRNDMklUoPvL02yMrIe5sl4ZraASdoLNEF5/csTQggDsUdo2eoQu6ylWpf+xtO8Wng6NFrKIXKeOzN7AI7JB4mtjB+Nl5XHtA05g+y87D5H4rEA6fZA4m/mzIlAMy5j8DwOzFopfMOr1UjTgKNzHk6KwkbE3rySrkqJTGDm7D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066299; c=relaxed/simple;
	bh=GHjSbL147+woEuEDHu1Sw2wgGVb8jF7lNaayhkWhvu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTaW4XgrWEqSLE3NvfKrf4NpTkRKgedUw19/kCHMb2OdEw3S28jQEmR4NMDLoUyv4sZkQhciDtCI8SZ5Bugze7n9h1r1Q5K14UhQtmLnRBbi3Nnw9+rBPrAtp6+sKtAeoOTGpu6o2cHwUeYtvgaLsCuJvmYj8dqeM4+tCPieip4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hq6mQPnl; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hq6mQPnl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so8474665f8f.2
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 07:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066293; cv=none;
        d=google.com; s=arc-20240605;
        b=BEyCobCPbg5nB6TxLjrKVg4fIIMVahploBN2T9rsdHnh3th3ySd8U2Cat04jmAcEDM
         s++SSB5aNNwHSegOvU3/QtjwAjb5Ztb0dQLjcN8E+Nv0vhtY4gHMy4CEF+nNp7wc+cPJ
         p93jPmf5VdWvj/iFzCn+e10Q59b1Z679lVyKc+SImkCiGnZRZBebzie323jgZYKOgq5G
         96q395bBlgicCndcAli++EKnjecBcNcBVcG2y5SbwNttl8IE4tN0FIK5lkG71+3piVvB
         rMWUjuUAABTAys3jjUi2fxR2p12OPHEikkZciF9ssNqL/bBXZqIemd4Biz4o3al2igZv
         t7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+0Vmq3Hp4b/auYqZr8FjphzD6qcX8xEFQj0zpLYQha0=;
        fh=d64xWfbCyS+gVzKow6qs1lk9FxqJj8tXiPlRoxcGMBU=;
        b=UMZeHq8wRV+RJ3Sijl8ieQxBAmtm6EH/uWj9PN1m0+PK7iejPV1SkTjd83f7qMtdWD
         f53wpcTmF4F+wBtNusxj9SQWPKvEWc6qDn5DMcURe5/DoTSwPeStBaTIkXI7GaGLnOAv
         cph7lu7ju50Xz3BApkU9yn+cId6qoT26SupGJZvRbnjX/dkPeUaH/fCfp2tiMHeAMtu6
         kO81Ug4taUmeQTkdVg6ydGg7TRxEtHzdhddJ0KqUfMhUFCuOSPLZaZsjZ17Ze8C2aGoK
         w2dtBcnhyeM2ffpUohMSrQQ6E39atlNlYln1SYltJC1iFAHtF9MnD6JDp4v3q22yx5Mz
         tySw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780066293; x=1780671093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Vmq3Hp4b/auYqZr8FjphzD6qcX8xEFQj0zpLYQha0=;
        b=Hq6mQPnlSyc0ww1/EIIE+gJItltSyFDx2eBmY8rIhVP1wefUlmwTjNi9O+4EdZECi6
         njHCjdKD0tFE4AIXEPzqLAe6FwabtbX/9ae14SZcv4PxrCWXcxMMI6NgIZU3K6KiW3p2
         PqWOSk/157p6chHJLdXhN2mDGuuv/WiyBqgFUuQBt2k6/qVV5gTa8YXKautcR4G7Fhnz
         eadxjqq/+cG+9CJLMwrWkp7B5ANtOBU8mHAMQSqfp0koNXgE0JgVsouq2IAg2J3J0/3Y
         hyZmvwWRatZ2tRamSC+ERRMy5jst9vWOEgMsgPykj7FKTCwUk01zmk842WkyNc6eqIzh
         OXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066293; x=1780671093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Vmq3Hp4b/auYqZr8FjphzD6qcX8xEFQj0zpLYQha0=;
        b=V6V8PHoOhoo4dVb0NhN2vqKrO55KBr1ZA8OzQzjHnd+V5mJfx9M1AxNBvJ6GW9cRCa
         YM1vRDjxsn3xe/arkjvaGtMlnK8i082VF0lsu318Vn31Z2hl/gYnyOXJ4YjWzo+O62zJ
         591f9QYZOGIntar14Z5+MEyLjAkUN9F92laCHwE1FVPbk4wowNbwKoJw3GXy5rhZpQZr
         xz7NWQdj62X7qfDsXLw0WO12LX3BKV42qJUAtDz/ODZzazCZCOqV8NmeZKk1RU+Aou8R
         5SE1xyQYiu8pDDWfvXfso9bvhwEnoosvzAEdgt6Ar6PKoP+PQFKGOASZ821qPMS2n/Sz
         4rRw==
X-Forwarded-Encrypted: i=1; AFNElJ+KpAA3yhw0OAYKvP6yGAWFgQfap6Qz/9h+tICs8Rrgz6aPAT/fLPYt2NY391X9VRLru2XJNVZkfbMIPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpXkzWCQk8gkgRV59yLNpCDoOZeu+Oea4zBB2XMUouveRhO80
	9SBJ18C27bbF+fqK1oTW3h6ccdagsV7zsQFT6xZDRKzl3ogm/h6c5NDUosBp4yPXEtwD+PXCLFg
	Lc3UOlgXbBaBM6nxykwOkRg2awPvBgO2R00WwCcBpQA==
X-Gm-Gg: Acq92OEjm+gxyHMXuI2kbUuNDYmmAsCCRJF0ber2naPWNHnVs7nzqr54XtBpN8wTC57
	/0EcrRg+FSjCbZb7llTiR/cAjn5QYADZiTFbXf5nk/bkk9EpxM5S4Mr93iPcf9DUH1iWV41DHey
	s4McJJoSi+GiIoCMi6dSBNz7BdSRaq/Yo8ZO9RfEm11bMW8kmyEDbamUjeC8vAaUJ0VFm7kMO+/
	w2sgMrZ46EnFz7BZxiZqvbGsL84po6HD7RM0DTZOblRDoaBOehun+TYrC/wxkYR8Q1gZXktjoph
	2obxTUnaJumYpfkL+5KuF4mPvGCXiNgNk4YWl9luy/kA5DPcgEWyopJtBxkphb0jTSvb6wAQCiH
	dlmGSX5b+y16mXUk=
X-Received: by 2002:a05:6000:160a:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-45ef6b6d56bmr140170f8f.20.1780066293416; Fri, 29 May 2026
 07:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-18-neelx@suse.com>
 <ahAfvPa_yl6AKZoW@infradead.org> <CAPjX3FeoGzNOBnmY5ie34irNaAOZiFqV_Ccf7dXFrZJeUXh8PA@mail.gmail.com>
 <ahBJdSKMly8rv04F@infradead.org>
In-Reply-To: <ahBJdSKMly8rv04F@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 29 May 2026 16:51:22 +0200
X-Gm-Features: AVHnY4L6Sj4CIQpoE8qqeTQsjviSoplxU_u3u53SGv7fIGYWGuBerFgqAZXaq_Y
Message-ID: <CAPjX3FddgRbmVOKPBTtyU16NqYg5OSzp3jAuVmetmu2uH14eRA@mail.gmail.com>
Subject: Re: [PATCH v7 17/43] btrfs: add get_devices hook for fscrypt
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 14:17, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 22, 2026 at 02:00:28PM +0200, Daniel Vacek wrote:
> > > How does this handled adding/removing devices at runtime?
> >
> > When called, this callback returns the list of bdevs opened by the
> > given superblock. If devices are added or removed, this function
> > returns a different list.
> > In other words it always returns a valid list.
> >
> > This is called from `fscrypt_get_devices()`, which is called from
> > `fscrypt_select_encryption_impl()` or
> > `fscrypt_prepare_inline_crypt_key()` or
> > `fscrypt_destroy_inline_crypt_key()`. All these functions walk the
> > returned list and discard it immediately afterwards.
> >
> > Note that with btrfs at this point we're only using the inline crypto fallback.
> > Is there any particular reason you asked this question?
>
> Well, assume you have a single device fs, and then you add a device
> later, you will not get the blk_crypto_config_supported call for this
> device, and it will not be taken into account.

This function is called from `fscrypt_prepare_new_inode()` from
`btrfs_new_inode_prepare()` as well as from many other places.
It looks quite OK to me and I can also confirm this with tracing.
Using the following bpftrace script:

```
fr:fscrypt_get_devices {
//      $num_devs = args.num_devs[0];
        $num_devs = ((uint32 *)args.num_devs)[0];
//      if ($num_devs < 2) { return; }
        printf("%s()\t\t\t(%4d %13s[%d])\tnum_devs %d\n", func,
                cpu, curtask->comm, curtask->pid, $num_devs);
}

f:blk_crypto_config_supported {
        printf("%s()\t\t(%4d %13s[%d])\tbdev %18p\n", func,
                cpu, curtask->comm, curtask->pid, args.bdev);
}
```

... and mounting an encrypted FS, then adding an additional device, like this:

```
$ mount /dev/vdb /mnt/scratch; \
echo -ne $TEST_RAW_KEY | xfs_io -c add_enckey /mnt/scratch; \
touch /mnt/scratch/dir/foo; \
btrfs device add /dev/vdc /mnt/scratch; \
touch /mnt/scratch/dir/bar
```

I'm getting this:

```
fscrypt_get_devices()            (   5         touch[26840])    num_devs 1
blk_crypto_config_supported()    (   5         touch[26840])    bdev
0xffff88a9c33fc880
fscrypt_get_devices()            (   5         touch[26840])    num_devs 1
fscrypt_get_devices()            (   5         touch[26844])    num_devs 2
blk_crypto_config_supported()    (   5         touch[26844])    bdev
0xffff88a9c3262b80
blk_crypto_config_supported()    (   5         touch[26844])    bdev
0xffff88a9c33fc880
fscrypt_get_devices()            (   5         touch[26844])    num_devs 2
```

Here you can see the newly added device is being considered.

Moreover btrfs only supports the fallback encryption due to the need
to compute the checksums of encrypted data stored on the device.

> Now can btrfs even support hardware inline encryption?  The way the bio
> processing is special cased I somehow doubt it.  But the concept of a
> static device list just doesn't work for btrfs, so I think the fscrypt
> side of this will need refactoring not to rely on it.  If we never
> support hardware inline encryption on such dynamic file systems that
> would be relative easy, if we need to support that case things might
> get a lot more complicated.

Yeah, this depends. If the device or fscrypt could return the checksum
to the FS, btrfs could use the inline HW encryption. Note that the
checksum must also be one that btrfs supports.
Otherwise we need to get the encrypted data to compute the checksum
ourselves. That is precisely why only fallback encryption is currently
supported. And it's where the FS callback hook is used to compute the
checksum.

--nX
