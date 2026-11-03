Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716296;
	b=23DoBNNW2I5vX49aZm2pbUEQFzS9F4OPjGGMihL0+9mCS6is210JnaA5qSmLn2RXG8C2
	 GVd6NjNgguQP3bpoWWwoXs1BPLvSAya0N5+l3pdf9+6R48oiaQInjJAsOboI0EcDTqfEY
	 PgQU/4WCvsq6Wwaa3gSen9zQhOcmHumUWO/9BF8Hyt5ZpxSQuQXFJ3T20JVZYcrR5aRsO
	 cCqRhjWTmzPz/51VCmp+9z4Mf7pNaKJUgPLYR7TXeZfB7t4SW4vR17MyIbdBhhO77E9D+
	 CIFN9as0UvzU1eaYmh6hsPhTcDlbSv7in3pg+Cry6ySQVoJCK/fdVPgyapwbUnvJ+aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=GTsgZFFvrMyWaNBWV/5rIE3ksApdz46m2HhnLxk9F2o=;
	b=xsBFxcivob7iJ8Z3IkScOMBEnIUXOeDL9t+hh11OVwqHDcS/U0UU3r8+M1KegCAT/iOl
	 YVq+YEpe10GUyz3PPFJPdxevKICnsA4umWRa8+fs/pTzwB3pCYdTPfDIXAvOXRbjB8Ajh
	 f3elN6EYtgpo4F92oJqGXsUf/SDiw9iYJbbvr6AJ8JjCSp7wu2c+PvB+Xa2yAk4hQTtBS
	 eG8VloowJ5IlFRWczS1CGZWoBKEtGyToMI5dw+BizN7qZFos6o6PEKEzC6hze5LaF1x4z
	 p3K697ZvJglXgbMPs9cTfO20bJRUP5mcrYrRfJxrqE0BN+Q5hnivWKuEx43gTHMkilg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GTaA7wk6;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB460A2602
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55CB460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GTaA7wk6
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14fc585291cso3355098c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716295; x=1794321095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTsgZFFvrMyWaNBWV/5rIE3ksApdz46m2HhnLxk9F2o=;
        b=GTaA7wk6Yo870mxJqe8oppHfYjD7Fw2XNYCLsA5bdJcSCVQq0WfCEx5Hkd/+Vqm5ml
         ybuBhJpPKKM4ifHnSH5ebVgWu0CCyg9VRu6ZlRVEBKD9MsCR+VJf4Onih/sUHb6MFwvn
         pBrgYCCT+p7/+K53bOAGr9VKgUeli9WqDR9h/T+rS0xeNaPjjrYzLBDGuZKPqoKfdQhr
         LbixUjeA1OT40WsVQ8djlxAVsjtgKbNE0mNCnRBfB5e5VlxxlxMZxF+ADfAP4PS327+P
         q6hJ5OE4m5hF+duZpL4hYqNyCoYE3tZpOIehz96KuN0fjNwaheTmJyAnDWD7WUSgNeIm
         zPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716295; x=1794321095;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTsgZFFvrMyWaNBWV/5rIE3ksApdz46m2HhnLxk9F2o=;
        b=jUJCayFcwSPCg+/zPRtljN/h4Nojtrx3GwFAC3TVQm9DkXnt3r97LIyJr4QWQBxM5p
         UDUfRHKx8HKl7e6IdOIhRBerlnL+92JTz/6dCZc6/7jIENnq0KQblF5j7fmbBIVMhBLq
         5c9fbf7NcbLeWRlnhqCoHf0zeeiJnb8H7dQ2etzgi+VzMLS92HrkU8qBDNphbgnW48Bv
         sZ6dXYg+hxN1pdI6MHet7KgApq3Y+DIBg/SRYk44LLWg0J/+sssKen3iGVrisXwJLcal
         btcbznywZ5D3Pvo1kDeUJvY/JU0dwzN1XSyxP709M4dFAPkDGhGXy9Wvzr9sZshdmJiF
         wYiA==
X-Forwarded-Encrypted: i=1; AKwUvBwYPjT+DzXNnkARt049q9ZyW7vjHbmgDxg5n62mes9CHBoe8eG0So+rMRFAA0dOxGgwzIDJXxb0hIOgmw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wyJ8wrtuchvmEIGk+Rj3ssxz8jygmqULsdRmq7aGtAzjOpu8n
	cOi3lSCRrratW8H7m7hyQVoLT9C7Uld+4MVDWhOhnctvB1HChx5vUxcORhYTVtOfEKs=
X-Gm-Gg: AYBFou0adFiPsINqB6jAq+YM/wgXT608ZkuYI3K3xlSJpkdgu0IibwPMWjG732vAnvH
	XHz4vGqoRZBd/IklOe/7L/hWYaOvYHqJNnbgYXUyYWJWsCNE0mkYcn8rDw4BIrRP7xky6NpBKFw
	yIo9X98U56DN+xBAGPFpSOwW79vZl+sVn7zqpa2WPqiTHojyoZanfIKiAjM7Hp8qTTANcv5LLft
	N5QoCzdu1DT0IVgRohAix3wgdcobg71P3YHI+JJlRbKSD+Pwu+wD942m3yHCa9yOew0WjULdcVe
	dX+K2AL8T1j4YRgtCqSPZIeoWYXh5wtf53teX8pfX1Htca3YnkeTDR+o8liadKI6VF65rzs/7JN
	NX6nxw/M10mTaHEsryxxGJ8ip8OAjZGQcaIEAsVj0fHmIPqvJavBSnT1gQBG9QrLmL/TBKjiXg3
	U5xu6mnSLWzHWsJnKlFSLCAVHZ759Coa0NEjOnhW91ijj1nZGgSADZ9AdCdJMPQzZxP6nDvrJTE
	wU/rYrYKcsrOWqxPbSu2mlqW7SDcv1JLI7pR7OzZfEsl9vdVD3NYLhFG7ePm3LRs9Rq8TkcALM/
	Up8vUL1GoTLsP5Wx1IKoTo96a/YWf7ShWZ9UG0YS/TerhyeRqHlEZQGEtgF7aYQIy1QAqAPvhLK
	vjpkgj+eMJ6ir
X-Received: by 2002:a05:7022:68a4:b0:147:8a40:cdf3 with SMTP id a92af1059eb24-1ac5d1d155amr26428202c88.24.1793716295255;
        Tue, 03 Nov 2026 06:31:35 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, hch@lst.de, Anuj Gupta <anuj1072538@gmail.com>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org, anuj20.g@samsung.com
In-Reply-To: <20261029105330.1427462-1-anuj1072538@gmail.com>
References: <20261029105330.1427462-1-anuj1072538@gmail.com>
Subject: Re: [PATCH] block: don't use the bvec fast path for dma-buf bios
Message-Id: <179371629430.3691261.8413921459497155545.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:34 -0700
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
X-Mailer: b4 0.15.2


On Thu, 29 Oct 2026 16:23:30 +0530, Anuj Gupta wrote:
> bio_may_need_split() reads bi_io_vec, which for dma-buf bios aliases
> bi_dmabuf_map, and interprets the map as a bvec. Always run the full
> split check for dma-buf bios.

Applied, thanks!

[1/1] block: don't use the bvec fast path for dma-buf bios
      commit: 801bddbf1e4147a69b811c548c35a06a157941b4

Best regards,
-- 
Jens Axboe



