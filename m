Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FD3793DB
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541799; cv=pass; b=kArWslURINRkC94DIRq3E4yA/BxKESDA4t/xI8aY+Voc3rGRkigutYtknhk5UCUU2muuldBL8mmL5d+FHe71U7Ha7X76Wa0xa0gKwrfxRtwB/8+teaq/mW3IYbgdadp+LmQClLi6kr7Z3fXXxNpk9ymbdd0qlQOqDZ1j4KkB0gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541799; c=relaxed/simple;
	bh=ZmMWtIGFF3qX/n1FkEv/i0UMSWQYCnjKW/3sG5XVFYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMGodANamE+l8FndIiAkviNVW3BHRkBy/qtw3g1UfkkzPFyQOyAsMs6fBpO0A2VzzghoMpzmbnweS/tDqcXdG6yBTrkbovtM4T9VUTX32ZHIBxwMdBkT52GO1UT9yO6YtlburfD3cK6Qb2Zg1KlVuJdr/6brc2EGVyvZTHojWGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GHTzb5YE; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GHTzb5YE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439fe4985efso897974f8f.3
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 09:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774541796; cv=none;
        d=google.com; s=arc-20240605;
        b=jKFq3dNiaMbCRpk+YeAcpRM/Lm/bwzCdaTT2Almw6Zey1OffGTkd92fhkpM0I0YCmJ
         yyi/kYQz38QvCp8v9BP7QKpWx3QMYMKkljZ8hFjRzpMyYxYXeWb4305WiKFSdqkzdsyP
         caOYpwew9r5+Ez4UBKWu8N+RS48GIcUeRVhPHlMCNHO/CSESgEIHbg0yyJYGKrZtyvsQ
         AH/1aeFXkvEFo2yKApb1KrG1u5Pe8fcbANes64B5LL46I+o5NoNI7E6js8Vl2VAuSwxb
         +bP7zl2hBew6tdmfq7wNRcUPRFw/cqNVhTMJ+OdGvQTgf0/OEaopIO0MMuN970mV57aO
         zMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vKJ5HSJrXHj5MUrcSTPs6jehjmYmFEBs1HNYTNjir5w=;
        fh=c3V+ZYHACDSVqYGvqMI5FZ/SEcTXt+47UPf/PdyvWKM=;
        b=Ih98WWTz6MqkrISBEowkqbrDlC2e5ObnXNS6j68ybygywSBKygqVcrt0Q24eComgB1
         LW84l6JX9WqY5S2umzZicBD5uPilqHunRr5gLXTfl/0O9bRjnGKMK465nawkHVC45ipp
         MeT+hY3P6lDPiqEBUo8nFFmKG4N8tydlSrHhw15gg0JYkWOo15weP9i+zzIQERCeM4lO
         d87Ym6c2MAEoRdRW9GwBcYpHzHxwEi+2NZyUe8m9oUXJvyIhTxGQcN7V7sJiFqqeeETg
         6+dEDZUoc5G+ze6meDGtuy8SGdJuiMtcrWcj+Pe3+vHJU5cvyJ/+TDG7SaGfaHf7Uo30
         NwGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774541796; x=1775146596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKJ5HSJrXHj5MUrcSTPs6jehjmYmFEBs1HNYTNjir5w=;
        b=GHTzb5YE5S2TLbpNpKL7/TdJUNcdkN7Xx38InyQjmvAm+KS0xaWnOet2OeXU8XeI8h
         RgdeLCaSyQGw8mCrvxTfVc6UKjKQD3gUteeUW79xC4+6EVNbZJyHcbrHgEuPmT7sFnHh
         pPqe45bbdL7ucog9QcAHA3UuMQyCbIh0IYtKkeNOU8TaNi/aNZgq9xj5P5VP1ZJzfnF6
         6H8w1qmC9w9MuGfJmiopq0ubsOW94rZOlYYGN+UuCHsi1xLMcUxK+akD+M7FDGedWsy6
         IlWAKpSGWOS7fzethAADcagjGcgKIv9IltbQY4/fM2w2mqzwN6VhNCvMSaEwztVWyBdm
         4yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541796; x=1775146596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKJ5HSJrXHj5MUrcSTPs6jehjmYmFEBs1HNYTNjir5w=;
        b=dayj8YBbWXDLJXBtiYyUo9ZKhpQCL4Oa7QE0QcBRxGoNWnlWMXpXkoWhxOa77++VO+
         KOdiZFfXjRCB2qRfjnQoXgqtfQhxMoHZLRYjMez/+MG6bsaUs5Es0qFCCHdSu84p7biq
         OrASokCWiKMnaT7cfCvv+ZODG7t9mMYHZBLTKGJTdhoxlLqtkPFD21ibBtHnvCux2k7d
         +t8WbnMx14h0I8Fx4UUkGKSTUpz7aSHVrnp5al1lNScOi9U4OqJbY7T+GgtlZbuT84cW
         BSSV4D7st4MOI2RQFxAlXC6Jjlb2by5UPXti++GGZ9JT9RPYxsQ1DAs+O/ASQWD5eYlG
         yXnA==
X-Forwarded-Encrypted: i=1; AJvYcCV48KklhIAL1dSxeVuIczfb82ykTV2NbvUj0gsvAJBae9fLHhlyjuUqyKt5FbR5lTVIi+KFnvBv1zD57A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPGOP9AY3cWKJCpqf9/IzfLUNZhMOT6m68wwjzRwjOFzafm0R
	YEBPWCnQWZ2Bb/DWh/QfAVIqWsfdC6mnqLi0n9JD4PTh4hZ9F7BmhTZmRU24u6SXp9hMCvoIlYz
	ttnge3Pwjo9Y218tsNtAZitLXGwfRMmhJq05xaJmujw==
X-Gm-Gg: ATEYQzxszZfQw0afqvwrlXITmM1hJmhOTTmvBpKFLkMlniRmRjSE9PsD+l5IUuVgxgb
	1fdz3b1iy8vBDgjvfcjRaHSML/hQRuVqBzkhC6xCV6UbZmt6OTpQGx+eBe3yqjhM8k12cDpqbdQ
	8UIR8nA5RxLbyDfQfAWKI0OFyFhGi2psscv+sOdkpQ3ox62pm35NMtKlYvsg7JSuAjL8eqO5hvf
	K5pWR0N9Hfi7CBXa6E6WfNNMZHkcm+zmsZa9ZloCFqyNENnnYMJLkTQc7NKdZHiGrxeK9y1aqJz
	nJX3vyvyW0dyS83IY3jzKgyd+FohTLGWRD2/W4wnhuqNnNbFWQ5Yd1FiDx0IjarYYo2rsxgLAS7
	8TWOS
X-Received: by 2002:a05:6000:2890:b0:43b:41b5:e023 with SMTP id
 ffacd0b85a97d-43b88995466mr13647132f8f.1.1774541795781; Thu, 26 Mar 2026
 09:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-43-neelx@suse.com>
 <20260208131745.2173841-1-clm@meta.com>
In-Reply-To: <20260208131745.2173841-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 26 Mar 2026 17:16:24 +0100
X-Gm-Features: AQROBzAGdUPAvZg0YU6QTXKdWZ2x7caOrhRysbF5k8uC5LR-I02VBBB483yNqVk
Message-ID: <CAPjX3FexW6D4m23OQQ0bNZRCJRfx0Armr3Lb8nvDR_qNMx_PeA@mail.gmail.com>
Subject: Re: [PATCH v6 42/43] btrfs: disable encryption on RAID5/6
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 14:18, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > The RAID5/6 code will re-arrange bios and submit them through a
> > different mechanism.  This is problematic with inline encryption as we
> > have to get the bio and csum it after it's been encrypted, and the
> > radi5/6 bio's don't have the btrfs_bio embedded, so we have no way to
> > get the csums put on disk.
> >
> > This isn't an unsolvable problem, but would require a bit of reworking.
> > Since we discourage users from using this code currently simply don't
> > allow encryption on RAID5/6 setups.  If there's sufficient demand in the
> > future we can add the support for this.
> >
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
>
> commit 6a39a21e95e116ad02c6ce9f832838acc111692f
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: disable encryption on RAID5/6
>
> The RAID5/6 code will re-arrange bios and submit them through a
> different mechanism to handle parity. This is problematic with inline
> encryption as we have to get the bio and csum it after it's been
> encrypted, and the RAID5/6 bios don't have the btrfs_bio embedded, so
> there's no way to get the csums put on disk.
>
> > commit 6a39a21e95e116ad02c6ce9f832838acc111692f
> > Author: Josef Bacik <josef@toxicpanda.com>
> > Date:   Fri Feb 6 19:23:14 2026 +0100
> >
> >     btrfs: disable encryption on RAID5/6
> >
> >     The RAID5/6 code will re-arrange bios and submit them through a
> >     different mechanism.  This is problematic with inline encryption as we
> >     have to get the bio and csum it after it's been encrypted, and the
> >     radi5/6 bio's don't have the btrfs_bio embedded, so we have no way to
>                                                                        ^^^^
>
> This isn't a bug, but there's a typo: 'radi5/6' should be 'raid5/6'.
>
> [ ... ]
>
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index a8adf99ad0a81..1bade8fea16e8 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -5198,6 +5198,10 @@ long btrfs_ioctl(struct file *file, unsigned int
> >                       return -EOPNOTSUPP;
> >               if (sb_rdonly(fs_info->sb))
> >                       return -EROFS;
> > +             if (btrfs_fs_incompat(fs_info, RAID56)) {
> > +                     btrfs_warn(fs_info, "can't enable encryption with RAID5/6");
> > +                     return -EINVAL;
> > +             }
>
> This check prevents enabling encryption when RAID56 is already active,
> but does NOT prevent converting to RAID5/6 after encryption is enabled.
> The check_raid56_incompat_flag() function in fs/btrfs/volumes.c:5558
> sets the RAID56 flag during balance operations without checking if
> ENCRYPT is already set. This allows users to:
>
> 1. Enable encryption via FS_IOC_SET_ENCRYPTION_POLICY (sets ENCRYPT at
>    line 5210 in this function)
> 2. Later run btrfs balance to convert to RAID5/6 (sets RAID56 flag at
>    volumes.c:5558)
> 3. End up with both ENCRYPT and RAID56 flags set

Indeed this should be sealed. I think this will do:

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5742,6 +5742,11 @@ struct btrfs_block_group
*btrfs_create_chunk(struct btrfs_trans_handle *trans,

     lockdep_assert_held(&info->chunk_mutex);

+    if (btrfs_fs_incompat(info, ENCRYPT)) {
+        btrfs_warn(info, "RAID5/6 not yet supported on encrypted filesystem");
+        return ERR_PTR(-EINVAL);
+    }
+
     if (!alloc_profile_is_valid(type, 0)) {
         DEBUG_WARN("invalid alloc profile for type %llu", type);
         return ERR_PTR(-EINVAL);

> The commit message states "simply don't allow encryption on RAID5/6
> setups" which implies preventing the incompatible state entirely, not
> just one entry path. The volumes.c code path needs a corresponding
> check:
>
> static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
> {
>         if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
>                 return;
>         // MISSING: check for ENCRYPT flag here
>         btrfs_set_fs_incompat(info, RAID56);
> }
>
> Without this check, data corruption can occur via the RAID5/6 bio path
> that cannot handle encrypted data properly, as explained in the commit
> message.
>
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 4a2887147ead4..aefcbe56e85ad 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -734,6 +734,12 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
> >       if (btrfs_check_mountopts_zoned(info, mount_opt))
> >               ret = false;
> >
> > +     if (btrfs_fs_incompat(info, RAID56) &&
> > +         btrfs_raw_test_opt(*mount_opt, TEST_DUMMY_ENCRYPTION)) {
> > +             btrfs_err(info, "cannot use test_dummy_encryption with RAID5/6");
> > +             ret = false;
> > +     }
> > +
>
> Similar to the ioctl.c issue, this prevents mounting with
> test_dummy_encryption when RAID56 is already active, but does NOT
> prevent converting to RAID5/6 after mounting with test_dummy_encryption.
>
> The check_raid56_incompat_flag() function in fs/btrfs/volumes.c:5558
> sets the RAID56 flag during balance operations without checking if
> test_dummy_encryption is in use. Since test_dummy_encryption cannot be
> changed after mount (enforced by btrfs_check_test_dummy_encryption at
> line 1547-1560), a user can:
>
> 1. Mount filesystem with -o test_dummy_encryption
> 2. Later run btrfs balance to convert to RAID5/6 (sets RAID56 flag)
> 3. End up with both test_dummy_encryption active and RAID56 flag set
>
> While test_dummy_encryption is primarily a testing/development feature,
> the patch explicitly protects against this combination, indicating it's
> an important incompatibility. The volumes.c code path needs a check for
> the TEST_DUMMY_ENCRYPTION mount option:
>
> static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
> {
>         if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
>                 return;
>         // MISSING: check for TEST_DUMMY_ENCRYPTION mount option
>         btrfs_set_fs_incompat(info, RAID56);
> }
>
> Does this allow the same encrypted bio / RAID5/6 bio incompatibility
> described in the commit message?

The above fix also covers this case.

Thanks.

--nX
