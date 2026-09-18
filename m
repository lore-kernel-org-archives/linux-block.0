Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2750AC0D
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746240; cv=none; b=CAFSU+64nUkY6AhKQmBwhnrIS7bdpk7Tlv3LVMo0qZfyvb5Mn7si+ULeNtks2LAU+o05GHa3NFYzD9VAcqoEDPh1CihzgNG8PuSWQiznTkj8XhpNQGUHUTh31mw/0tNtlKHTBexlflRtHtNjIv2addjnpmBhRiPckQJVWUUHluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746240; c=relaxed/simple;
	bh=C5AWntZI5VfsdkhVNOlhJWjuARyHAh4CGfTREDIJj+8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=Dg6vb46Eb81WFJMvkWJFWI9KYTZvnkJGhMKo/v6+5DsLPiNGCTdDHOhhtyqb+fnCHw9ZfO8qELg3TKq9QODJq7tE3Ko20PApI8ul3AdpbLz2/wchpmPFooDVT61mGMRxDmhtvmPuORGxMzydDuab/sXLVOMiuX6yADPfL89QeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR9+soVg; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR9+soVg"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so141636766b.2
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789746235; x=1790351035; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5AWntZI5VfsdkhVNOlhJWjuARyHAh4CGfTREDIJj+8=;
        b=aR9+soVgGL4K0KTpu5HjNLJkXqcbTxvb57pKBs5lIyj7YfMZkK00Eb2bOLDkyqgy6q
         W1BGp77qdE4WpZWCKpfmoja4QWPd2MV5G5jIBsMvXST1gfwrLivSA+QkPgjBaZpNzB+s
         HpmuRVzdX2T4sgB96qkMRSo8Aw0CYEg8fA2WTTJC88IMnjRogv1MjPgeiFD5SEUu8zQm
         DuiOpXt7kQ07aFZSvXKBZxh8KbGD5Ud6g72zEW9TmBILUu7VwmQlWAJI3LAt1pDR3xUC
         6AQQX7ePR04BdAMldOJPlbxd/x+OSEc5Ii3zsZBAj77GAv0qrXrRE4kQ7GHmcLeGBzJJ
         pZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746235; x=1790351035;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5AWntZI5VfsdkhVNOlhJWjuARyHAh4CGfTREDIJj+8=;
        b=Q6Utyy8HAeNEfTxp4rUuv+bcibGKTi6dpjn5d0rCbRl1K8R38R8JH3Ew+m17UrVEfy
         oY8RgSDoi/LmxpJvWmUZ3t/0fK9O6cNTpPhdliWBdjj4i0ck8Y75Nd2lYxNQIW6IL0zs
         GFYT3aMAFqFUpSCh3iwHxj/oecFhpOmjtfN+1DhSBRKE+dayvJgjcsNzNRA5Uxz81NQd
         UBOA94IR5kGPEQWEsDLoKIEb5fKJ2SCFkk8JVCy+74JmhLwc85iBZb6F+zKcZ66HqwaX
         ZFZdsJ2WU7zxDr15jyJhgJBX6qYfzF93QJaU+ci3tJ4FnezPoMMcX4PZHSMxCguTa3Z9
         cCnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJW5MhbjKFGhUdeSbEidGSDfUxwCxtFwX4e1+uXsiyTXww9FQS7Ru+l7NOJSwLnfY6AhCVd0QG5Mzzag==@vger.kernel.org
X-Gm-Message-State: AFuF++nCQS2dnRL7a3DqufTM1Pf2dqVyBU3CQL8MmCvP91Bt8RDuMYnI
	zMmb3W32SXRRUV9MQsXME3Rgv/1V6ax53aVvvIWufxUcsq3rr/3sYdYJ
X-Gm-Gg: AYBFou2PqKBLJdwWurC+D2gcqDjPkBTUBU4vN2kMc1DhRB8b54e+Jd22JINP2r4KCHv
	5ovQV5jhv3KASvdQRXBEdZca8BepoNGC6b3S06fNUy9vrnfJk9OlDcXPhvhlOUXr9jTcTLmEZ2q
	mKU/zOdRQH7v9a6YT5p1cmQKczXwHpGFwNcb5tkVhkpgk+peifpS7bR+TPSYbHhsbJCJDyKp6aj
	HWoNobYZH5d8ta9b8WN/wHuvw1z9Z1U0n+Smuhwupdmf5WKznI3oPPgIi1pOUkMn0tr1iEsYiFE
	OoufIBUx1mICLHvrsO4+O6tduxMni00JTMNmue/E/IrmG9rBy7UZLiBzyCHRQFsaIrgzvURO0cx
	JY84jUMQ6ibotXzkGuhTKgxV7qJWQZDnEzlqEnRyswGQcTtIZSmvv2f5MD9kd/NARdou3Mss570
	9jNlGibk8GD1lfqYOjP80HreXXp6XlSoU3SnP/JiQswzp6qMDL1NZuti24ZFrNNQ24Zi6u62ufo
	KVvrk7NRVKNmqLaWLwvsGScU3dDHUcRoKvinfzdAFwmadlLAh5ewsZiVV3EBN+SnrtSOIZ87lsf
	RTAy1KbYDjgz5U8=
X-Received: by 2002:a17:907:3f17:b0:c26:19de:9126 with SMTP id a640c23a62f3a-c2a15b3401dmr300021466b.25.1789746234745;
        Fri, 18 Sep 2026 08:43:54 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1b7a442bsm78355366b.4.2026.09.18.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 08:43:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 15:43:50 +0000
Message-Id: <DLIK37JYD35X.3NZ4ZHTHDKAFX@gmail.com>
Subject: Re: [RFC PATCH v5 1/5] blk-iocost: add BPF struct_ops cost model
 support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tao Cui" <cui.tao@linux.dev>, <tj@kernel.org>, <josef@toxicopanda.com>,
 <axboe@kernel.dk>, <ameryhung@gmail.com>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <daniel@iogearbox.net>,
 <linux-kselftest@vger.kernel.org>, <cuitao@kylinos.cn>
In-Reply-To: <20260918031751.1255420-2-cui.tao@linux.dev>
References: <20260918031751.1255420-1-cui.tao@linux.dev> <20260918031751.1255420-2-cui.tao@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 11:17 AM Tao Cui <cui.tao@linux.dev> wrote:
> The registration and binding model follows the TCP congestion
> model registration pattern: registering a struct_ops makes the model
> available by its name (char name[IOCOST_MODEL_NAME_LEN], validated at
> init_member), while
> io.cost.model binds one registered model to a device with
> "model=<name>" and unbinds with "model=linear" or "ctrl=auto/user".
> Unregistering a model removes it from the registry, but its name

I don't think it's what Tejun asked for in v1. He asked for a per-device
struct_ops instance where attaching switches the device to bpf and
detaching switches it back. Instead there is a global name registry,
a lifecycle list, an "unregistered but still bound" state and a
refcount_t on top of bpf_struct_ops_get(), and every version since v3
had a lifetime bug in exactly that code.
Do it like hid_bpf_ops does with hid_id: device in the struct_ops,
bind in .reg, unbind in .unreg, and le
t struct_ops own the lifetime.

pls wait for Tejun's feedback before respinning.

pw-bot: cr
