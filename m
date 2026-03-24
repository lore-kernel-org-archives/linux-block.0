Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106D19C54E
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313714; cv=pass; b=YeRqgMsa+A9d2XifZ2YO8ob2qqjIbMsu7ewi20kl+rhXWxLP6APvPso0143giDVo6/CsszQpTo0PVPdNa+6ScQzN0T9qooMTWFO7PRBfA4iSWLBScUnwKMKV50LIM6hC8A9ABcVOInrrNJ9r18/sanUNzNbpyCqR/wZb1VCkP6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313714; c=relaxed/simple;
	bh=HxtuXJovGdFtvO/g0aPG6G8S4ZGyC235+Any0lZK9I0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jg9WQ3cDkcwrK1v3gJFtK+89FhdqGEQ7qPseUFqLYXRWhbygFXYxdexJMkEQxKc/zTPdTnk0Uq4+KFFR4kB5h0xg1dLKSaQgsmO+SH09mtaVyh3uVETBhHYjSoBR5Nn320HqTPQkc7h8kA33Cq92Yzx7rZ3QJ7ZEIbq6nPVxyx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gptpc97i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tj6hEuik; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gptpc97i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj6hEuik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774313712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rNMnhbVlcAruOYvlrOijLU6TL16d6X5j1YTOGwOu/KA=;
	b=Gptpc97iYqsVoD4XDUtzUvm/Vahithy31JBzA/Td33XdZ4z0oDuJj87PaFaIyYI7dgkg6C
	6mau0oMv4ExpFOtS67x5JAoGUBeoiNWVLUjHOIuVXEWi7w7ZCydEy4hrRqAfKL+WYj7h8N
	P/HEgOovHpDMaFCxJEGHm2ahZQBzNM4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-f-GKXQIXOBCYvImF8KTFvg-1; Mon, 23 Mar 2026 20:55:11 -0400
X-MC-Unique: f-GKXQIXOBCYvImF8KTFvg-1
X-Mimecast-MFC-AGG-ID: f-GKXQIXOBCYvImF8KTFvg_1774313710
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38a326b8fa0so30846971fa.0
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 17:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774313709; cv=none;
        d=google.com; s=arc-20240605;
        b=DcD17BU/y/utQSy6E95w2QzIUhbEBjALEWVGRYZCv4XsO15gYt3W0E9RQ38jfkDxcn
         z50n5W/MsaI1d1ldvB0olRCCh7J6TROzw7mPYhqVM8Y2VCNVUb7v/95ZtkWtH/pGisaR
         6ovySzxh38NoMKtgaTpBj6fisfL8mQao5Gxxxbdk3uXUkgPUHjrK7CWeG8F/Z1Cwwdhn
         OqhaTn327sa9V51dl0oyImsOj2m9LjQQjTjiAiFwn1QiXQLbHZvOqJ6PZ17dZE+hZBn/
         Jr9bQXIKGHpv6hTPsKfmUjuODTy3bopCWvw2uRb2NNf6OKOB+DZIHkxbINh9QzQsTbiW
         wO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rNMnhbVlcAruOYvlrOijLU6TL16d6X5j1YTOGwOu/KA=;
        fh=+Ppf4gSXSg96w0vgjwnoa6EUvMZXRxgVaX7VoLlFcIM=;
        b=Dfl5wF+1EtqA0lMwKdxBQ7z/H7s+Aul66YJrQeDzTDrdyPiYNmlXMwRMMRL7mMIHyw
         LaULrZXul+Qd1VgMIA9mSVZUXUZ1Njk9BQSn39qcyHg3davEbl2n0iYh5uzusnTubT6h
         n7Nb6sw74uE12rtOcKFOQGRgLlmEOzXkPZ9sisXi3KgER4IzIafMzG3sSgpmQHu18kkg
         dRFk7EJn+RwHvY2gVIBtBA8Fy7EDPK5dqYLez7J8qt33+9aVqJrir4lS26bx/qYGpOh8
         qSpdJQPLsXbWmRNeTFbyVmO7tAiplKVYtBfmr9Qmizf83mwXZyuQH6JGLe3Yxzmbw1cX
         n4ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774313709; x=1774918509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNMnhbVlcAruOYvlrOijLU6TL16d6X5j1YTOGwOu/KA=;
        b=Tj6hEuikFfxLnm9u+TBZ7n3iJtywqc66f2JWMMkw50t/U9UPPaKCUT+edIyOmVvojG
         fjFeIMPJOfxifdJEhX9el5luv2nyCpVIgI+xzM2/jYrgR/brVJhgQtaXl0eiqzZj5RTt
         9tijGkXnHoVpsE2jhjb10V4JN2ij5qYB0i8lVNCnQDhjbT6APkay/m7i8AJCJ4TKIzmp
         05SBN8D2Wvua1J98f0H3Pd+ROjHbrEXS5uBWmZUpCn475Gpq820qfvxNjyqcgqjFmfCI
         KoDg6tnC9Awv6wdvDhTCaK2anRDK2v3fNQWDJAKWGz6b0OXATvO2EpM3HZmEblnpkpk4
         JD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774313709; x=1774918509;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNMnhbVlcAruOYvlrOijLU6TL16d6X5j1YTOGwOu/KA=;
        b=kgkYPodtUYpptNwxFr5daNnze7zBgsQu4A+oCu7FA93aLBFXWnltCXyUkaWKkvRdj+
         O91H0jm+ZsAzHvjbQgdSgL47cLpBU40VYQ0rToHGjFtmo7Ak9u1nBLBiLTyu9y1dDI17
         KuSsWlG3wulOQ0Z3saELTtsbT3EengJZ7LzGllS5AI2RiA2N4mbd/nyPSftaJYM5/vWW
         GI21B+UuKy4JJHWcOqm37gZ/XlHOXpVhEsHf3Bxe8/0u4gtDnY4YnEAW9JiN0ti8Xl1X
         wg1owWuB/0ibZ30G3/XdpszZ/bWDgxBwIgfFdrlk32ZFUYBHuLF+BctXSLKFt8MSlQKY
         RRgA==
X-Gm-Message-State: AOJu0YyF1Ote2787zNaoUey8mfzrACu/BO3MeDzoBXRrxM7r/iywryb6
	dwm2Pmf7GZNSntZ5qyFIn8V2GTPwrcadR+TpXiH6ZjQyGxdywAd9YjPN1C+puQnhCKS0Gh76uiy
	2lzYjsrZchYAtK2nPL73kz6qAxBruXGi2Rr08g8buvyLoGctcHfnhWgVJv2nQPbheVuyMRzpSnW
	7j2qkeN41/NF89SLa4Fvhe3m2YJnyPL60qT9W1WIE=
X-Gm-Gg: ATEYQzzF06lcZcKIXFp5aoisQJmyN1Yf4rgWn6UE+6CfQYhkJMwYahKNBPYVoU9saNn
	DFK/nyeUVE3CZ5ZM0F/GSXDWsCQLf5sDRknFDZDmbRTOWOJxz9O6uHPn9AuV6xiPtRVnBagosdf
	d3jCwFUjofr/vOspYTAugZYJepUi4Mzt+LCsH6RyOMvE8XJtLODzip1kb03d0OGIAkXd+0A8qrj
	Jc54Vn3E3RYXXSJ8+3oHBTKTR+TAMfzn/vmmCJQ77dL5k9nwfo=
X-Received: by 2002:a2e:a9a3:0:b0:38a:61ce:78d5 with SMTP id 38308e7fff4ca-38c328af794mr4892161fa.11.1774313709461;
        Mon, 23 Mar 2026 17:55:09 -0700 (PDT)
X-Received: by 2002:a2e:a9a3:0:b0:38a:61ce:78d5 with SMTP id
 38308e7fff4ca-38c328af794mr4892021fa.11.1774313709013; Mon, 23 Mar 2026
 17:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 24 Mar 2026 08:54:55 +0800
X-Gm-Features: AQROBzCd2X0HSqrZkZ5_gPcp4_zLBh3e0B2dNGJJen5DEuw_a4XyQymmGvSP9sg
Message-ID: <CAHj4cs8o5HExeOX2YCYrWH86iz4xwL52YtsJNV2YOyDPbyEffg@mail.gmail.com>
Subject: [bug report] e2fsprogs 1.47.4: mke2fs creates oversized orphan file
 for 1k blocksize (breaks mount)
To: linux-ext4@vger.kernel.org
Cc: linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Baokun Li <libaokun1@huawei.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

Hi

I'm reporting a regression in e2fsprogs-1.47.4 where mke2fs creates an
orphan file[2] that exceeds the kernel's maximum allowed size for
filesystems with a 1KB block size[1]. This causes subsequent mount
operations to fail.

This issue is currently causing blktests loop/007 to fail on latest
Fedora. Downgrading to e2fsprogs 1.47.3 resolves the issue.
And revert [3] fixed this issue, here is the reproducer[4].

[1]
Kernel limit for 1KB blocks: 512 * 1024 = 512 KB
[2]
Orphan file created by e2fsprogs 1.47.4: 1024 KB (1 MB)
[3]
6f03c698 libext2fs: fix orphan file size > kernel limit with large blocksize
[4]
# dd if=/dev/zero of=test.img bs=1M count=1024
# mkfs.ext4 -b 1024 test.img  -F
mke2fs 1.47.4 (6-Mar-2025)
test.img contains a ext4 file system
        last mounted on Mon Mar 23 20:32:40 2026
Discarding device blocks: done
Creating filesystem with 1048576 1k blocks and 65536 inodes
Filesystem UUID: 16683060-ed47-46cc-a040-c5e049785831
Superblock backups stored on blocks:
        8193, 24577, 40961, 57345, 73729, 204801, 221185, 401409, 663553,
        1024001

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
# mount test.img /mnt
mount: /mnt: fsconfig() failed: Structure needs cleaning.
       dmesg(1) may have more information after failed mount system call.

# dmesg
[ 5985.339637] loop0: detected capacity change from 0 to 2097152
[ 5985.347473] EXT4-fs (loop0): orphan file too big: 1048576
[ 5985.352939] EXT4-fs (loop0): mount failed


-- 
Best Regards,
  Yi Zhang

