Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438D4399E6
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311146; cv=none; b=KqP06PmdtwW5chDETyk6lzuBHGwdmykosZiSnJ16x58ge9b2cJQgS35yMNmec21aiwJzulkFkpPH4gkC436cFfhB96xOpy3GKNoLNRLGOV30ghcjwHb/YV36XfCAAhVmGoqroJa1YvwNeZmOS1Ar99UZ9iHT7VsSV0iLgjCJ9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311146; c=relaxed/simple;
	bh=bqwd1tkIaEiz7ICq6XhgCjWOPBALhXUjko3GAdaePy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=niwUNI/074MhNcrNvoydWf+UtpGoyVfljSCpcpGuoymSDbJXCqNF/LCu6fY8OBHvFUI0NhqXHsWJyyXX9vTMC7wnM8VtD77B/HgSWqxXLqbZu+8vg6nbgr9Rv2B1Cv8ocQXg57l06s8nj4T61BEFGVyV3BlQI3CUpiedzvqcc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7LCpmjw; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7LCpmjw"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso116146a91.1
        for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792311144; x=1792915944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPNQGJOaZ7JO7aKwrLR1/0X2/lBd0SCu4ixEzzZzDGs=;
        b=f7LCpmjwO+dgi8YC/uKLaNYfhmu/yWvUWhMxNrIdi4bSinUslfA5btJZDxtyhtZRyR
         cObTI5N6uKkQ/C+gY4HscJ/5FaUt4X2GzXJ+F/IfSBnLppLAYZbcZeVS7RcTcZZr33cG
         mXb1MhwIQgO7sMpiNLuRQB3QrTN86LV29hZHsOgl45cGLC/zTP4r8Gd7Q8cig8/HvjyK
         ieVHaMCiyqmz316z2RPJgv/J2k6P7NjfhVWow9COLZcqUcDaTeVoTEaIhdDH13Ov9CsZ
         D9bWMOY8wbbIt6IKt51tXbgEPQFJYineeWmAyjBdIDdbNtjSYTw6WeesXX32v1FVSq2s
         ogFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792311144; x=1792915944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPNQGJOaZ7JO7aKwrLR1/0X2/lBd0SCu4ixEzzZzDGs=;
        b=Kl/Prwrr1ATpVj8dzFrMPziPlktqsFSHAJ2b0YtUrQidocGj546aRuag57Yk7KJj3X
         uKpLFyuP7yNuM94KZk5Gz8ufpw2Kd3L60soUf0Et1bVkwtObgofQs1CHu7/Nd+ohSgDd
         ohzYUTuOlPU5HLkgoiDMENvmotHP3SmpumyOyryvr4KBPXetDESZZv/QPGiB3nt5YaU9
         8HbnqGsnv58tKOdr64TUTmDAmUznxzCbgV1yxfpYSaTGrZ4p7F1zq/f+vAZEXmmH8vIm
         M1XqyH/elcxVld8EmL73XyGYhCDL+Chj6ThRo2XkwCkaXaZnd0myccAD4I1AAM+PmeQz
         IlFw==
X-Forwarded-Encrypted: i=1; AKwUvBzbXityPIudnoUsc9a/Be81bNQw86u016CzyJoN+3+0W0jIueGx3AVqmUN49gNmqPjQQubhCNNd2bvMeA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIf0jjQsKWvX03MHzzTSOy8vbGDdmVDSJUmn3PpmgPeynTZ9xTI
	4kRqp8M7XgocGRT1k2OO2cfdEAWNRJa3BVGxZtWB6LhWHVSuOasKsrf8
X-Gm-Gg: AYBFou38Qy0D1pn5w/oND4hvRZ4H0Lw6+4qn8ZGJkVzU3UpmGumbmkUtRTRXN/kbAKM
	exmYe5MmNkU5OrXGLOib2LTi5c0LcDRsmxKelhr3db9lc1mngLK4Dv8R04EQ7PPgQFnk6vVNN/Z
	9hL9B0+rQnbaLssFZCilI45Krjqn+g8GZRlhUQiu/d+Xr4n2Bo57etc3I+RMzPvfhGTE23SSywh
	uR30+9vbCIuwwAlIwh0oA631kktcZJ/+dG4HJZbYzJQ0GIWD0ChJkCGKI4jsDDMbLiRCclB80hc
	sDA3E/n4Lq04vbNFyLtX8pbkE8VovRlAZdCLHl0oI3XU35MtEkc2aMf/GqP3cgoAA7O/E5eBxP+
	ivWoCvjzZmTmuv2dSp7PZSPSw62LIAsZkT+MDVyvSj7s2/YJI5LX/yzjESe7q3dJy9o3o7qGh38
	757Ue2nFRfUMv/h40LMBeTZ22VCl6N/PVX8dP06INTp4UPbZTVifDOsNpenS1RqK5eAIJimQz7w
	yxDxlA=
X-Received: by 2002:a17:90b:5743:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3acef0f479dmr3814438a91.41.1792311143904;
        Sun, 18 Oct 2026 01:12:23 -0700 (PDT)
Received: from amax.cluster.local ([115.233.223.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc49c263asm10637039a91.17.2026.10.18.01.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 01:12:23 -0700 (PDT)
From: l1za0.sec@gmail.com
To: viro@zeniv.linux.org.uk
Cc: akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haocheng Yu <l1za0.sec@gmail.com>
Subject: [BUG] KASAN: slab-out-of-bounds Read in copy_folio_from_iter_atomic
Date: Sun, 18 Oct 2026 16:12:03 +0800
Message-Id: <20261018081203.2431035-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Haocheng Yu <l1za0.sec@gmail.com>

Hi,

We found a KASAN slab-out-of-bounds read in copy_folio_from_iter_atomic() w=
hile=20
fuzzing Linux with a modified version of syzkaller. We couldn't find a repo=
rt=20
of the same issue on syzbot. We are investigating the root cause and trying=
 to=20
develop a fix. Could you let us know whether this issue warrants a fix?

The crash occurs on Linux v7.3.0-rc5. KASAN reports an 8-byte read 8 bytes =
past=20
a 144-byte allocation in kmalloc-192.

Relevant stack trace:

  iterate_iovec (include/linux/iov_iter.h:49)
  __copy_from_iter (lib/iov_iter.c:261)
  copy_folio_from_iter_atomic (lib/iov_iter.c:491)
  generic_perform_write (mm/filemap.c:4392)
  ext4_buffered_write_iter (fs/ext4/file.c:354)
  ext4_file_write_iter (fs/ext4/file.c:794)
  vfs_writev (fs/read_write.c:1058)
  do_writev (fs/read_write.c:1104)

The reproducer mounts an ext4 image, opens a file, performs write operation=
s,=20
and triggers the crash through writev() with a crafted iovec array.

Full reproducer:
# {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: Sa=
ndboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cg=
roups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false Ni=
cVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:=
false Swap:false UseTmpDir:false HandleSegv:false Trace:false CallComments:=
true LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
syz_mount_image$ext4(&(0x7f0000000540)=3D'ext4\x00', &(0x7f0000000580)=3D'.=
/file0\x00', 0x0, &(0x7f00000005c0), 0x1, 0x50d, &(0x7f0000000600)=3D"$eJzs=
3F9oVNkZAPDvTv4YE9ukrS1V+pBiaQNqYpKpoWChgVIKlWLVh9L2JZg/hk6MNVGMpbSVQvWhD4W=
+tbT42qfQCqXtw+7Kwj7sg8uu7JOssPuy6xIiq/uyIrPcOzNqzCQxJuayzu8HZ+ac4x3PN3Pynb=
lz4N4AGlZ3+pBE7IiIGxHRWWkuPaC78nR5cP5kWpIol48tJtlxZwfnT9YOrb2uI30oRLRFxLWLS=
ez9w/JxZ+Yu/HKkVBo7U233zU6d7puZu7B/cmpkYmxi7FRxYGDoYLFYLA5t2nvtu3N+ouOlw/3/=
PXF76pvf/t/RJL6Xve944n1slu7oXvpZVjUnEb2bPVjOvvxYPWnOMRCe2m9Lc9ubIuJLEbEny//=
OaIrK5D348y8+6owPP1nptf//9d8/2MpYgc1XLndmZQV3ysALqxDpuX9S6K2csseOKBR6eyvn8D=
ujvVCanpndOz599tRo5TdCV7QUxidLYweqvxW6oiVJ2/1Z/VF74In2YER8ISIuNW3P2r0npkujW=
7vUAVU7It75969OtHaskP+pm015Rwk8D2n+j/+l6Xdp/Z48h4aS5v8/7039KOQ/NBz5D41L/kPj=
kv/QuOQ/NC75D41L/kPjkv/QuOQ/NK5a/j+8DldFRaXhKnmvQwDA1iuXk8j7GmQgHyv/NMh7ZQK=
et/a7zXH8sXahep+OQrV8PSK7I1haH4yI1ohoiogHUbm/X5KeQ+QYP/Bstp354628YwAAAAAAAA=
AAAAAAAADWdnZw/mStbNWYo69t1UisZGG4coFnOu+Xq6XyL83ZNZ8RbdGSXSeaZNeB1iTV60I3Y=
vF6RHeUFm/+6+qf0hLVv8MN/rd8Rsy/m3cE5Km1mHcE5Gn3T/KOgDxdv5R3BOTprYW8IyBPR4/l=
HQF5+vHBvCMgT39dzDsCXh6OiH319v8K8ZXsuS17fHL/pyMi2xfaiCOvR3TH6P3H+5bv/xRub3A=
YVrEwHHEoIi4v2/8r1A7paqq2Ppc2oiUZnyyNHYiIz0dET7RsS9v9q4zx/vSb5+r1H/tbOv8/76=
3t/6UlHb+2F1iN43bztqWvGx2ZHdno+6Zi4fcRu5vrzX8t39uyvd72u4Vl+79d1ee07FxljBvtX=
9tTr//ccDr/r/SsPv88T+UrEd+qm//Jw2PSWt/s1Om+mbkL+yenRibGJsZOFQcGhg4Wi8XiUF+2=
HvTVVoXl3vvqP75Tr/+N++n8H7pq/vOT5n/76vOfrf+Pbg68/jF++Oo3dtXr/80P0vm/9fGzrP+=
tyfEswNZq3/mR2dkz/RGtyeHl/QPrj/lFVfs8ap9XOv89e+p//38xe66t/81L1v/13Cf2Pz878v=
16sVzszb7/98n//KTzP7pG/idL8n/9le/OvD1Xb+xdV9L5v/bTtfO/mAXTU+1x/re2p52gvOMEA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACARvJpAAAA//+F6yev")
r0 =3D openat(0xffffffffffffff9c, &(0x7f0000000100)=3D'./file1\x00', 0x1250=
82, 0x145)
write$sequencer(r0, &(0x7f0000000c00)=3DANY=3D[], 0xfe00)
r1 =3D openat(0xffffffffffffff9c, &(0x7f0000000100)=3D'./file1\x00', 0xe502=
, 0x145)
writev(r1, &(0x7f0000000ec0)=3D[{0x0}, {&(0x7f0000000840)=3D"586b0859f4af95=
118770", 0xa}, {&(0x7f00000009c0)=3D"8ba6b3ff28e1552261532a8638589a01ca943d=
1b338821b188f6fde1a219b32ce19f8a192be9a4cbfdaecab1b63dd528fd2a7b599fb7fda77=
9c1bcdd4cc19869a665aec8de9cf096226d5a2eb4dbfc3a2cacb0deb4a2f7ed94b6df317a9e=
3d7006cea5b4b74a6aa99d29e3b44743df80dcf0410bea753e08ea154402b9fc39c75ab138a=
cbc6b78db0573b64f403e9936bcc0d5711e4b251bbaba470b70ec40969d972815b551b8ec8a=
044571ef208f09e1c5a579cd099f92abbb9a91f04388779aabd0597f60fd3be4dd7ec5146d8=
35a4e19bcbfde95601fe01e774a6c7f4ef1ec9187c539e1dcf0dfd16aecd883346646e2e61e=
3219ecce73aa675cf8b565b0e14b248867f5e294c66cc9fe0a5ddd210f6aa39cddcc53f8090=
d16a68e48ab4dd031081d884001a4f3c22a9c89a13ad23452176831bdce107ab98953a8eae1=
84b620b3aa38571bb9fc3184dbd19f2a9ae40a43954989e99aebc611b8a8ac18296adee0fd1=
74bdba86721352647a259d3457f739b041bb27fb275a5a5359e497ed1477ff9f2be119278ad=
4385c7798ec6c9a677906a1fa3b1fde811a7a19bfb04d5a48941c30f8025bbef8a7535b3253=
b79b34cc2994906dc16e4c58acad1ceaacb3d6e6768ef349ea1729186e0a7128c61099927b0=
aa3920a3f26721aad8ca608faf2807c2c14cb203acad936b55b203dd6bee003597efc5ee82b=
ce06cad5fe49aa3f43f779d2145c2233f79e369f07ad7a17e765326240a23101f3c77014468=
7a7fca1ed59daf2ab4ec957ba25df7d26c59fd2d0f5524b5336b8a908fedac32413f35ae0b9=
a5cd6320dbb5869a822af03e21ba13265d86272823ead509786b64198096b779eab4aee154c=
491142ade2bea7fa138639fc639f6503d740fbce3b73d0999f85a8e7af2e7d265be30ac747a=
84da01eb0ef658a54358b8f4760e2352b776f552d5ab5c51f5816c6829dd527b185833ee4ba=
fc14db9a21041473242c0a1f68040c03f2a306fa980ccdaa52aa9a0c4859dca6f81eb4e5754=
a821a6e6c3d99b5559328853e945a42a85f430e872164204652e7dd076c4ab71e80abeb509a=
0681a352ee837aca34f3ab01fbb740a93f1cc1481730cd005db430bd6ce18a25a8fbfed6506=
108e8a1d534aafa5c9281373ea9b435bd8f492c3702faf04fe364f31f360fec4503879d5763=
14c353f315285e67c8f869d0809a6ab40dcf5804fb276b829714f99ece3b81490a2eb99521e=
535e738ca97b55804bcda92bc907e14c6c5825487ddf026c9018c787acd028d8a38ca5d53b8=
6169b7d0cf46c48f7e675bf7d876cca862bcd8115c2f72fac73f6f0db8de16f5a18c3110bf7=
29ac7400591839b89bf63643610c168a76d466aab7eba6c20be83a419aba0ceab172824f21a=
063a17ee3971ccf86a3cc410e03813b42a207536da", 0x3f7}, {0x0}, {0x0}, {0x0}, {=
0x0}, {0x0}, {0x0}], 0x9)

Best regards,
Haocheng Yu=
