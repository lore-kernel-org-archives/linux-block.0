Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C503D9545
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356056; cv=pass; b=h5SuRFITP8pv3r9GCSy82LNkXvHeMzhrX3H+GgOHrrsLh68WF+15eOdPEWhh0p4tQN6En/dESao1e/YlBuzFI7nl0zcalJT7Rpkycm462hNIRycdIytINLsEgoe0a1uNMY2Vd9R9lRCLu0j83N0Ru+jfuR9nz1x56lYSoROKS/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356056; c=relaxed/simple;
	bh=Z/QlDjEqmTsvd8hmVsRhjPJAPZKduCsAshcn9SEcHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSqAq1YzJOwhK9jI1NMFXeh+09KGnHeupi0JBfgokPtEpS2OWR0ViVaet8eUiRWSK4vDmBoydngZVvRcMPLHfVpuNZNhxMVwMmtdeRhAOOfA/HTvbopT3o5Gu4kwgJj+ses6UBx/Dw8XHudCk9FQp/+o1G8I8s8FkcQ6oDgIhlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JQ7vBslB; arc=pass smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JQ7vBslB"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f05ffcso5102805ad.0
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 10:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356042; cv=none;
        d=google.com; s=arc-20260327;
        b=JGBODmBJuDs9EZa7REWrQBhUVmSBNk+AvisnhtSI4FEJ6h4R/BbfjA8l3jA/d0sIXH
         UMaj3LMfrIEN5w6txyOhfjULOgBXcuLBr/iToAu06LA9Hy7Zu6PQq+Ui/BQOjg28YN43
         s+p8kD0WMJfc/la687zE7kcvlZwruKpNVRAhjt9Y5Y9UxvYqJ5uJ1Cx/BxI8BZD585HW
         hJ1zwX/9RYzwEll03GAscsz3E815Ge0hMQsAT13dkQvAqmNOnlapEL3uuUpCDnViUehO
         acSC0GgqxI5QU+HyXWQCCDIPqMoyBaIQl/Gwhk+7j1U7MpvU09ZJLzvoMs6dgA8G9O/x
         NbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        fh=PNCY3/UI7LXgA8BfM1PuP8qsgsh0hTso73WFNb57OWI=;
        b=qBsBW0/LWf/BoLow9pLTgfX9y8Z9ZMHZN0aTBK1P+tmigfi/Qbms1OxhGppSTsAkCm
         EV6oPOWp9KA+7lx5buJN13VV+OTpVFiMfPAkA2nO1C86XOKJPKB/3/wLGpm/9sT7iQPt
         frVVO9xUwJHZgx39zNnPeaEfHhG0hyGc9LVaEWrypj13aBMHcc3EdY51fBWzVWofzT65
         V7teJW/oNK759k8wukg2Ed9mJUszhRWy30zhl3ALMJ6g5i429x3y3erue636m/r5MdMz
         V4uagxySknQOl3TFsuMpQuXH+EfTyGEZTfM3JnXIeznQEETRP8g955RyliNkNpd9rsGc
         WHig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790356042; x=1790960842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=JQ7vBslBA75Oz3vhccuiegu2ZSCVFqSF0HyjC/3/vNzOkrP+yD6f4D4JjYMSYAoFrr
         wlg7Wmn6oEu7SXRotz0a67VZfHRO6XibZ9ZQ2iaB3D1nQj3Xnbu+DnvAmLPuwuabcTJk
         PXz37aU1zp89S9iK0/x3WEyWrQZ8hNLRiSYpSLIsFe52Q0ZtYHr08wUrk94pc3ENWlQd
         J+Tedgfpmw+/PX5h3yjumGEOqc+s3rcWYPx4Hn4luwZxasnr3NVcHxFxvCE/jfitgeBw
         +jOt/CmP2fD13Y486VYHbVYAPN3U4OMa+qtVuZhbWJD5jm5g1hu0o/Zq9FL93oXYU7V4
         vv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356042; x=1790960842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=fN9WIwqYkKAhAnVD/pmn5DCbeyWdWd7KyFpjDnQHipqATyMqqi3PVO95o76WHA44Xm
         HC9JfUwBu9aX2D+w9/PcFFdL0e/Oh/RDzxfvPI4RRDtN54bvmjVK9gM8FsFMsQoITGoB
         kgSJkU6hevOuTDdnQ9onQku8CGrokYfv+pf8fkeT8tBpdtEr+D9TPq8SSnoPqLOa60Sx
         njDthX+McoQQcoN26fkU10Wx88KKFc/yQR89Rat37E+7g7fcZX8TsmY1xZVTxMV0pcSW
         06nwFd9lcI7AwD+hPzkUmU0KiF0E6fmghuJZJ+vPnpZca6cIOhjcnMmMRYfNl7fWd87W
         zuDw==
X-Forwarded-Encrypted: i=1; AKwUvByEdJQfnmgVk7LnQG7Hem+A0mfP8iU8BlbMcuG23UDpulw2ODr0Cy91LSlxAof94VF/tYzZ51dXINA3Ig==@vger.kernel.org
X-Gm-Message-State: AFuF++mTNMt3gYGKVdLXPCnbACSrjiyS7XqqPoG0yVPFrhwfgpo7T7OR
	I8e+PFmSOjuxRnvs0rShWMO0vLHZNMqPgodDoS49S2bs7RIk1vVQ4ZX/4bStuZZLm9I0wkq6saC
	GiTwJms1K5eqIcAVmakMRvlPCbUKZNMWbxSJhXkfe
X-Gm-Gg: AYBFou0Wr1IPATTn0rPooVHh2ay1bvA6bppHAyoeQB71V59eaGHI115hPRLJbrgddTr
	A/q0whgEfGy2rPBz99SsPSpE2b0hqqDsNq4nl1hFMfqikjNk0ax+kfQelJx40x4JEOD6IrztV8P
	XHuS06Ne0NVkiTrRGlomaHUXAo/T+sg1ZOk+Korbz12h9gCZtVCkM33dADAVSZIJpvLQLKV6vsy
	0d+APFc2ClRTJCx2TNv+qteMCwLWOyvk7j+w0fmIjbm9rFtBNNkp1mDtCvm22qNrMcYy4HfLcOE
	dmIJNKCtuntX/xGJOJ0T1KupNZ9Hf9zXflZ82zghfMTpWhVxPTL4XDt6iK2xRrsSk/AEQssx2aO
	vZIeDAt0MDcNtl5rjzrvSfw==
X-Received: by 2002:a17:902:d48d:b0:2df:99e6:9448 with SMTP id
 d9443c01a7336-2df99e695bbmr12902675ad.61.1790356042370; Fri, 25 Sep 2026
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
In-Reply-To: <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Sep 2026 13:07:08 -0400
X-Gm-Features: AclHuK-PYyMWIn_xv6i13K6lF_3RP26uUOO_mtAnUMGHNcMrV5ydBitx8qn_ri0
Message-ID: <CAHC9VhSeXmOHvioZ12aVmnOtpP52-G=K_jS3K0fTSiCrDHStPw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Cai Xinchen <caixinchen1@huawei.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, jack@suse.cz, dhowells@redhat.com, code@tyhicks.com, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	miklos@szeredi.hu, amir73il@gmail.com, senozhatsky@chromium.org, 
	chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed i=
n
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
>
> This is mostly fine for me. @Michael, for the fs side of things I would
> give you a stable branch vfs-7.*.shared.landlock.path that you can pull
> once this is ready.

This is in my queue, but I haven't reviewed the changes yet.

@Christian, I'm guessing you will merge patches 1/12, 3/13, and 4/12
since those are the VFS changes?  Once you have a branch for that, and
we have all the necessary ACKs, I'll merge the LSM changes in 2/12,
5/12, 6/12, and 7/12 and then Micka=C3=ABl can merge the Landlock patches.

Are we all okay with that?

--
paul-moore.com
