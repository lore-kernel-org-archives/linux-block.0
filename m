Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9C155333
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449482; cv=none; b=n6OJVseZh1DW2WMqY0y5BAdt7vxQLDoEyJ/L9r40EC2FFrA27++qMoYmX4E2seusz84skZuJXiYXTkglVT2xkYbv0hPi0zxTkPEJKIchIJrdVp9Az59eCe/Nqcn4m/Ddrc7aMApxxOaGvuLEhMDmt0a6PapWOhgsX6K6tR9meMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449482; c=relaxed/simple;
	bh=hZGypJa+0gC0Pd2rNeu26LZsUEfunosrIkjMfNWiLZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biLbS+jQN+qMT7ugqB4mLNdmrSF8N9UIOU8j8eKtCNw5XPQEDeHO8/hZ4P+Zkaudh0dxkooiC9ZWYz0t/ACxLL4jZHOX79roe9ghNMRsZ4UKBhByB5p4p+XOSyl3udiKNH9nS+/O8uZW7fDtkAFpZkI7IP5KY/JsVPXu/ZTbiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j6j3aFpQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6j3aFpQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24014cd385bso62313765ad.0
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754449480; x=1755054280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTFIJh5IdYRfmXRrV/kBcUsFP1nFJtd9YZ0qDXPL8CU=;
        b=j6j3aFpQLDhSd2h0qJgA3WMFO0FU1u6CGBDWKQIVY6atMGZiAlNe87E9e+oQYEkiCT
         kpj+9ctNp0QgiqtlS03HSKL2wBCfaoNpEIHDCYfUGsxox4plIKjvC2rAWAIGgYHRaOw5
         jv57skvhWvwmQeteys2hO1owIIBbuiHDZxdZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449480; x=1755054280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTFIJh5IdYRfmXRrV/kBcUsFP1nFJtd9YZ0qDXPL8CU=;
        b=aLxJL2Dvqc08ZjKa+ftzdswpvOntIoWEOraSG6aq/LW2lcELrdcbeF4PjnTfH8MIll
         1MZomJrqBJlVLWMDaJLQXz+j3FC8xq800QAJWENpKUkZHJY7N4iIr+DxcAuyAPt4btWy
         KZ9b1/cEKDpBMvNnh+SZCf/C+X+Z/1EmL8HcogbjQXyk3Cxkgy5lSgNgg0YOEd6kD+Xu
         jEzRYTCdH/ne2+MtCGlipatBf8dlgt2YL4KrBcY9OJywafjKkCJfkliu/z0ry5q57/AJ
         yMRy0r9tkH8Sg1L72P6yxS0ThIdO2MV+mj9qjhj8YovCW0OewhLMW/DJAZb4K+gLd2CH
         qN+w==
X-Forwarded-Encrypted: i=1; AJvYcCVkKIC18ILMGc5bbWZ5pu9oGf4cHgvUxZum2pKpV8ReGjdmxw2k/MYNzfJIg6b+YQ7ImhohUwh41SpL6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyViEOpGolOeQ8SgTst5IOxNlJueLiLj0Nf//Itis1sHS9KtN
	ZOel70m7y+AmXJwZhBKr9sO+YN6vUSYL8U6S1c7+oiPyaFqNmPjFPZXJBy/zOzCQcg==
X-Gm-Gg: ASbGncuHaIRSR/mhL2TKFLmVfXU8k0d0lpKEH/3Q6hq6IghiLCHUAFhUVzTfa4mtbC2
	A1ppUUjYCc6WmMNJel76kD80QY0TuWfqpiCj9mKYV2N3Kp/87Y/jRcKrL2fND6qvPTyOb7VGzTD
	DYbwmQkO0gw1GX9ma1v5QJmKEC5ZUw+m8JJ1nCtAuQqGZjTgn8uiPuN+v1Ny4JLgTMFnsptRSig
	a+J2lbr62oZ93TmoWwNUd0R4WKp5FWF22pEbfPmmcP32qOSB2ywMhJWn2OJUDyDFfamc+OUWKP6
	L5zjHc7MAZ8vEXM6jWg+xH2Yc49yZ4t3+Yx78HROZy70b16zxfaPHrS9AVdxt/crHaPcbj+eVNP
	id10xE222NufDQhQosG2xvUE=
X-Google-Smtp-Source: AGHT+IF1L7Q+LwjpClF7GXDoVkELUC8g+IiurmJj34+qJEJNN9hK8LfT1l4Yu4vqTUn7fr+mkOUoOg==
X-Received: by 2002:a17:903:1a6b:b0:240:8cda:9ca1 with SMTP id d9443c01a7336-242a0bc8284mr14055655ad.50.1754449480245;
        Tue, 05 Aug 2025 20:04:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aab0b3sm145806125ad.161.2025.08.05.20.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 20:04:39 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:04:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <5ydfoytbfcvgkxxvc4s6e7rjqzldldjanq3jgwlonm3pczpysh@gtf3u6hibkri>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
 <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
 <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>
 <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>

On (25/08/05 10:43), Seyediman Seyedarab wrote:
> The NULL dereference (which syzbot reported) has a much tighter race 
> window: it requires catching the brief moment during zram_reset_device() 
> where comp_algs[prio] is NULL between zram_destroy_comps() and 
> comp_algorithm_set(). This 'can' be triggered by racing concurrent:
> - writes to /sys/block/zram0/reset 
> - reads from /sys/block/zram0/comp_algorithm
> The window is only a few instructions wide under write lock, so it is 
> significantly harder to reproduce than the use-after-free.

I honestly don't understand how this is possible.  comp_algorithm_set()
calls are done under writer ->init_lock, which is mutual exclusive:
neither concurrent writes no concurrent reads can occur in the meantime.
