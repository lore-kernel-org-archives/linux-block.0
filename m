Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370527;
	b=p8/iqkmrq7LmQpNhEV7ZpFoVB4DqOJEf1AMJjXcnf/WiZr0fORLvfuopUjUAnezdla4j
	 9jspwxQlDbk6bRfHQoRp2Myk05sOxy7gbBU6lKLpGD/p+QlUOMkqQf0iUBCDNGF7YqLeO
	 jfm72lRotmIDGSyIv3yubgZNZLi9JMkOZUsTYNRjiUyfTFINe6T7wcACuCtnUfnbCNTP/
	 +V/KDwF7e6dcP8YPP2Eh99T2A8knx1hkIuR6F9IV+OpzeDeJiar3+D4U5uwA+hTMuiDok
	 6DfAbY7Z/khVGO2VUQe8oNGxlWwhtFV4HAf0S6WMyqDaCI9b7bI5X+aErqkrn2AM3zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zqiKMWOLSQyjwMbkXK+aSiPK2rl2ZK7WmqO7AOWRX9M=;
	b=HNSxFQiIQAQb2cN5Cfi6m4RjSoHj7/eHvZJPlOvwcsy6i8JIiFAx4Dm859qN8m8oW5tN
	 7jAajSe/ZUggnqk0W6U5WErUcAdtJvI7cnE/JE1uysAwMEqP6O3Hc4TD3+CjuKDC2/eH/
	 8Kv+K0mz3TvrAgLQLX1xy892qf+5NWK9RgF8k8WcFgxIbTtXRylr6hjVwJrvQR1M2RV8j
	 zR+ZApoBXTHj8phztzAMt9+dl6fPPJMpGJWePlB/ytWbw7LXkrJW4R2xDPvgSDVRdCH4z
	 e3cdPV6kZ3WObsNd44FJ4/vw0Ve0j0L++BftfpYYuC+sZnrscYw6qoJRIgBS0Ovesng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iwOmAI6q;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A88606A327
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A88606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iwOmAI6q
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ed0890476fso14807245ad.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 20:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794370526; x=1794975326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zqiKMWOLSQyjwMbkXK+aSiPK2rl2ZK7WmqO7AOWRX9M=;
        b=iwOmAI6qEsa+sbCiAKpgglOhpqxUc/bPKHY7KDyvC5gnUx2Edtf/rJ6i0Jn+KAyaFb
         6TmSIlBNTmJw89M+oJo4OL9cUVcNJ+LkGkvojDY3CNxcINw9xtpgYDVoZQgQNPKUaKqF
         igYl8MvRn3ugVA+lKlZwV6Aasiyb3nsgJhyyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370526; x=1794975326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqiKMWOLSQyjwMbkXK+aSiPK2rl2ZK7WmqO7AOWRX9M=;
        b=ohtmCPoNZ6DAytdfzNbbcfrkUa9Pw/YIQ5pCiR+FxOwByFeMkrJqzMZSQASZOHDkvG
         4xGMj31+LanS1YAnh5lvnzQ/z22zYEE0b040FcdCUXkpgexvU5NBhtRSGYIzeYyKMqRb
         l/PoLMfUNEmuoJHMz89e+V4C2p4r9db2nRKFrM/0WsTCDPsuDQrvl5AnJjcg4MZs3JPt
         mS4nLnsT9j5WhW0b3Gu05h/aemTeIxeg/CbjNBcG3CAacNL6M7QIKczowRrMKzBS4YlX
         V4c4s3L1CEnBiSlhWe8euCxSpKlQV1FKJFhkSt1YyoflA+V+LZRhn5+z2NhernZgObqF
         i3GA==
X-Forwarded-Encrypted: i=1; AL+hErFfedYGZvEqy2aNnkG4G7z30ToENa/HxUMkyB9xSEVYpVCX2j+VZuncu3cfS0LSvMRf3qv9suZfLM4lxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+aSsUAhwx+S44ZbJSxN6fAEKtQ+nPoVpRMj/6HIjfuWqPxg3LO
	RE8CF2ZfhAnpuR2wNDDrivsD/em1htoqceg7EjEoj3CchToXGgVsGv5IAuTpHkL/sg==
X-Gm-Gg: AYBFou1w8H+/MXQeNio13JVt5WoNKXBEXobkIpWlAirO8rcRwOlUhIQ1C6vt6UAv6jv
	qGaU8CCAt73onr6/pmJNGwYozyyo1QHfyYrtHZ7oBgmzR99gbi/inHpMvU5NmtSEOLdv6Wz6Kd7
	Ygy6Hh5rKUks2V6ySVAjJWsOOVClP46UAAPtX/notIhtrtO5bXA4IG4ViEXmB/3ScFyapi5Yppj
	tVZL73QKU8v/gSxF7LSd8XzCpZp4DjrJoK3Hbk2ACY/mzFb8IAADog3R1Ye33Slb2J9aeZy/pHl
	Vczu9aCbWhwXVJBFALLuFsmz+bDFhh+fsjEbwHCQ4dwgvwc+ATr/laXQff362QSQlb7X8rwsVTQ
	dGAYZuNeca308QQTFKbkiB/AAexhQy5P3GabHP/oGL35TSCuT6PnfapViJDaEAr/uU7Li9b/qzU
	YsQt/yn1ZYlDOCyVseMfP8pdz7C0HMEG45KQUztMcA5b89E/iY8pVxFSESzfCa9ugMuX38EmpAZ
	+53AJ2tveTQ3HY9zC1df7AYFPnO5Qkr+j2MCb24ad921l0STDmqR+LIlWRy8lnzkK8+RsSAg/9W
	E5tVxRDO01zmAOqc/uNdYnTrf62F4gOcZE9N3MqVhBZT+4+VTLwJk1+n10J7g9QxXeiCPQ==
X-Received: by 2002:a17:903:94b:b0:2dd:ad74:ac1d with SMTP id d9443c01a7336-2edd79bf870mr15709035ad.24.1794370525821;
        Tue, 10 Nov 2026 20:15:25 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7bf46sm16294355ad.31.2026.11.10.20.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:15:25 -0800 (PST)
Date: Wed, 11 Nov 2026 13:15:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 04/11] zsmalloc: switch handle type to struct zs_handle
Message-ID: <avPrwgD8lrQQLBlG@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-5-senozhatsky@chromium.org>
 <avNHoaIU-RV8_fEG@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avNHoaIU-RV8_fEG@google.com>

On (26/11/10 16:35), Yosry Ahmed wrote:
> On Tue, Nov 10, 2026 at 02:48:09PM +0900, Sergey Senozhatsky wrote:
> [..]
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index dab71f582103..3a6a7253fd01 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -264,6 +264,10 @@ struct link_free {
> >  	};
> >  };
> >  
> > +struct zs_handle {
> > +	unsigned long __private obj;
> > +};
> 
> nit: Update the definition of ZS_HANDLE_SIZE to sizeof(zs_handle)?

Ack.
