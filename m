Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724702;
	b=iuhjm40m621uyT9NIJR4uFmT4hiEYQlrjK690lRu8x3dEHmtk5GRySCcI1LPKmBeX1F0
	 4G8BQI58Yz9S3yWdPAjN5c2kR+hLdCzsKaCE7jyaw9hQxCpLoLsB0Xf+5ltyycyV6Y7GP
	 oqfkjJIqZztwnxf5ekStvJ/BUNhqxQlc60xml5cQbJp5zXpSVQnVMRwtx3g4tq4gt1YeM
	 S4jKAqFYMnXykgwzGLw0Qznvz8Sr9jw3rtGsj9lyt0BX1fKKZQTlmUC4WtwV8tW6ZmKB5
	 3WH71y8YnQ/w8x+A8SwcTzdFrw8yDP7gYjhK+17CDNRQotAwxklqBVxqACQDWtykuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=z/+aYEPLoBSp7AxjoxxgYR8cgspXFyNdt6Vr/KNLDmE=;
	b=wsci5lYke6vo1LHhxGqHoSYwTyY7owztvdVw1VaBDVxydDoBWGezOZsNe34yjZia7i8U
	 jkevkyY6qAY2zdAGEyCPZ0T1wRLFCxyXjqsKuokSqJSKU2AollnZhi2Dq8sG4DhH6P5Ka
	 qFwvMA3n29G6Q2H9Lrv7BqJlPqmAacwGO9mYVn8o9+ATyIrQSP6w2Fo/TR/krfgaLISAK
	 C/o4vrHCJjNE1s1Klb8en9OZnddkAnlmxP+sehFlOBEOT4XN1X+JoVSFSNWsHkuBbI4bh
	 n/XRznRMrDRs+FMS+NUCou5P5AtZOU/uO66S3UPjZWh7suIRiX+OXU81W9BwD866/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTIFtqdT;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C8606A331
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 16:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B07C8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTIFtqdT
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so2897133b3a.3
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793724701; x=1794329501; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z/+aYEPLoBSp7AxjoxxgYR8cgspXFyNdt6Vr/KNLDmE=;
        b=eTIFtqdTdXpA/AfqqKkL10HIQZLcduWeqawGhkY8XSlpOW7wAg7SwK7IyckCmAeC8z
         QZEJnVKKbFm1lme2SYMMxv1HNP1Njw8KJE3QtzbovqqCyntSjZr0OxFCZk8earTy7ZeP
         s5VZOXYH++PjPF1kTEA3lESRC8qsEpTcVQUri9WLAkuFv2cuZix2S1MDadbIk2gWxXcO
         a1CWIRWP4N0snge7OVszIUi9zzUBbb6XW85sc28z+DIK0qUMW3AE1Bt1XJHJEohjeBO9
         ub6LOMq+gg31oFsCGTjAhEdvsMpjkdKA0Yw0Eq/2gp4qZRvsM2ML5GSPlkglQB80sBeL
         ogXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724701; x=1794329501;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/+aYEPLoBSp7AxjoxxgYR8cgspXFyNdt6Vr/KNLDmE=;
        b=nd+Pyh4/cIo7CHj4XcEfF18ytSvfN9KIu85pLRZS8nVVCyJGkLSVclLjHrTSEv8P4Z
         nS1Ha2bCGWG9ENX3Md+2qVmwHRltqIlwiSFLfjLhr9KLjGJR/pkNnZyWaf3t4yZnffcE
         W4MCYOmyp00y9JrIJoR1KbujpGoME1PncOVyMqrGjta7vuAawVgFpmaVprNd6+nX24gy
         TAPvH0Z7882/oAdxiqoVWrooiPfu0gD/R6UD0XSIh4yDZMrEUHZmVIDgmr4xJ1vr7wWo
         lAdNEYG+BlDXNjmLPBAt0Jwt4uO2MP7QQ9MpQYJbgTQ+gr6ksYbncTU6OySPJnx4uaos
         /Ljw==
X-Forwarded-Encrypted: i=1; AKwUvBxa1GHUAgJ/t7rXEocvEsgLsups7P4KZT2wkWN2bOtx0MPG/f9CanYNJf7jBnXV2RUwD7UjwvuTaJTlnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cyAQHg/i/XzrWP/F95MeVQrkxdJqCkv2eG+O8egc/668SfB19
	BckmCK3vZgwBsnuuGKolO96t3jz54qREnGf/ZTEsFVaoqy0lkGmQaYO8
X-Gm-Gg: AYBFou2nxjyIA/twC2g/HQ0oE+8dCisFU7iN28vBtT18f3VGkp+5Mr5k9WftCnOEJQ2
	XojGbSsABNov+T2/blBIghy1llSKgwQ3wRkiBT1CR7X2H3EIhanCSzks9e+Dd6l6htqdchvpGgR
	EPo1jWP5cHQIJpcpfikm1QJu5ubw7kbrGRIb6TsPcLpowFxmcHURpid1VZuXLt5FevJMrnh4Whd
	Unc6h7J8r1j3EGpyLsDZtf9TZkpkTECskt5oJYpHqZdgw7LViV8NWApJTO/DjLV2QDE2N7bmXmf
	YdxTd+uYOO/SW3AM7aZcyCnDMzXz9/v6VoZRnXAYWkf/W76DNEx7sUKdJ+XERj0pZ8gQKVnoUrq
	NC9AkMeKqtR7uyoVbMc9Ui3aC0vk9NROdXVjXgv0blkirL1KBlZ+u47q+VmCph/WP9zds8jAFWI
	IVZCENmagdDv4an8cxXPTIekSUStjxwFlorJB7XbfSfFAOuCPIJIkt4r5BcOZH0A66+0sTSPRlI
	8ALp9fpvxw93iqOhZU4+TUu2dXtFkfTH9emux9Avh+mTAiKONr+CkPWCC2aUb3re8COB8jZxX4+
	tNnG/YB0IH+F1N3AOjxVlS4xuHeaW20KF71cdIvXPDMtMzH9mBfXHZKkyx+yORUa8zAF7ucKulK
	R7rXVvrS91zQsvV1OjKMnKFo6s3E/gcAixQ==
X-Received: by 2002:a05:6a00:3a12:b0:8a0:2cfd:87cb with SMTP id d2e1a72fcca58-8a9bf90ab27mr11070101b3a.43.1793724700510;
        Tue, 03 Nov 2026 08:51:40 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fccffsm3794904b3a.7.2026.11.03.08.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:51:40 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 16:51:39 +0000
Message-Id: <DMLQC758A2C3.175VOTFQ2Z8HD@gmail.com>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <daniel@iogearbox.net>,
 <linux-kselftest@vger.kernel.org>, <cuitao@kylinos.cn>,
 <ameryhung@gmail.com>
Subject: Re: [RFC PATCH v12 1/4] blk-iocost: add BPF struct_ops cost model
 support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tao Cui" <cui.tao@linux.dev>, <tj@kernel.org>, <josef@toxicopanda.com>,
 <axboe@kernel.dk>
In-Reply-To: <20261103132613.1952975-2-cui.tao@linux.dev>
References: <20261103132613.1952975-1-cui.tao@linux.dev> <20261103132613.1952975-2-cui.tao@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 05:26 AM Tao Cui <cui.tao@linux.dev> wrote:
> @@ -3223,7 +3306,6 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>  	return 0;
>  }
>
> -
>  static int ioc_weight_show(struct seq_file *sf, void *v)

Unrelated change. Tejun pointed at this hunk in v11.

Overall makes sense to me:
Acked-by: Alexei Starovoitov <ast@kernel.org>
