Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63237471274
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865350; cv=none; b=bC0PWs5mPRUyRbQvw6lqaAXOW6i3zKBXPZ+afUtdk3e1r1uDNT8ilBYbxG2yT3tQ9SskfjOMqJqWu88OlDaw2fW+S/iae1YcMbUkd5MmSsX+LyN8HF/5AUe9yfsfRY/AqvkP6Cm2g3HoeTmYwfo0jY7JpNCYVEFKDSlXHbJNriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865350; c=relaxed/simple;
	bh=+K4HZZsUyx+BZ/jVUFt5QSnww12hfGtHUXInz1C3T8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2oLDMq94VlEJKBt52m5uSu5PbUMsWeKWO6hizRQvcBJWitine4M3lUHwKNZS0m9SA7tyn82ZdZPAPD06yAHb1JB8dJyktKX0OxSZz0u8XCYNvJ0YLH1pn0jSW79l0RatHGnecruON5VlHyUnKvVvnrz0PPUoK2lsj6xB8m4vUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AeKdo/IK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AeKdo/IK"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1794764a91.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 21:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791865349; x=1792470149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=moe1szgBS8qfOMQ+dx39iq+IYSEcWmwG3cQfQWaqcvA=;
        b=AeKdo/IKd/Md+Sf/OL2oNjaEijynaXekhX+r/J0FGKDhOIss/7IUw9XynWO2CyD1HT
         LOfyggL9vIlq7KMg7afdFFs5moLsw6ukA/ts2aiY6j769/VGYVSS135VnVpA+MxGLYwL
         x9UxDKfwpyV4nCUTTaJzsNQeFeR+fgi130aiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865349; x=1792470149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=moe1szgBS8qfOMQ+dx39iq+IYSEcWmwG3cQfQWaqcvA=;
        b=FjFZl8DQzs8Y69YkNSGn0mJFePx0Mpxc3XQRfkxy6qrYOEibAUCanIliX4hZGiTBUg
         KDrhNxHKs8cHgxfduKdrHz4ChhFROb+d/2/6f6fxxLQD4SGp+4Y9p2PvIg5OK5TAiWD1
         chyqtgujZ4CXNqVTUAueF/C3uKZRlMyCtH24dz0LowYMiXgZPOyUzsXSjm9ZjAiHsTF4
         4KJPGdi/JzrvX1KhPF18cRHOaPWofDKmcInnMWiKi4g662JrI48afJrf+HxX0KwkCdSa
         mhhBw8BTStNY3ZuIKTSsYaYxId500CyK89b5cJEZs2Okqxiy3LM0QDVdEIQPr49PLdfV
         qHMw==
X-Forwarded-Encrypted: i=1; AKwUvBzor3METTves5LyoDd5pi7jNp3Slp/V85ttzZqlvIF2o+uc1pje1fSSSckP0Ld2513shjgzt2obFLMjjQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL0PhRJjV4ljJCrkPHC5b7itF1Er6p82PYfEuS4RYXruRGjk9y3
	rfwqB7ay8fndwplal9er8iPkBK4a6IRkWSlzFSrT9RCVDXyhfAPQeJvO5r5ja/1vgQ==
X-Gm-Gg: AYBFou2t7QcGGMch0MtQwY42pzLIuNN8O9V7qTQALFfonRbSFHzQp4Fut55AkYVPnyI
	tdKxY04USyGyxp9hNkqh/p99Z7b2EUHxwND7njTok5KY1EIOKYJb1asOPVFcwvbYvQes82joYz1
	/5z4irXW3GrRKO1pEHbK6vKMx98t0tpF5TPXs4UG11WS+XIpZTc9fWwARQQU/PnhZv6Gg9GEkib
	u3Nuz1D5LUBmrLTbovAe/zbU/4NgxHw15fnQyAmZL49iUReLuJS64MqFnfQdByiQMDll0JxYIT5
	39+Fg3avdU1cKkko22tTvNpLtRt7VLMKM2efNqfpDWH8L2LTqZdQQnZkqq7DZMBt3YNjF6lV+DJ
	54chvxOvX/o39PwtionGv0P2NBBdDDKbafI7fvZQFd82K8jg4XwGUkm8Y3GWV5yrz1MsB1a+x1q
	TT+VS6q4AVED1lWHiVHY87jhedWemW5d415237YE18XiwXg950N4AD7nhJs2lwdi1wC3qDImnh6
	6pg22/2OsVVzVc0QjhC5pIO7ecKB1s/1mPQdQ==
X-Received: by 2002:a17:90a:b90:b0:3ab:be66:ddb7 with SMTP id 98e67ed59e1d1-3abbe66df61mr3465361a91.47.1791865348806;
        Mon, 12 Oct 2026 21:22:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39533ee7sm11566916a91.4.2026.10.12.21.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:22:28 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:22:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org, konradybcio@kernel.org, 
	abelvesa@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <as2xrbm55Sjq3T1M@google.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll>
 <ar4070oH8lRCJMRw@google.com>
 <6713512a-d879-4fdb-9138-12e125c21ed6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6713512a-d879-4fdb-9138-12e125c21ed6@oss.qualcomm.com>

On (26/10/10 02:54), Georgi Djakov wrote:
> >> So entire qpace should go here, no? Why did you create this entire layer
> >> of indirection, singleton management under drivers/soc?
> > 
> > qpace seems to be standalone/independent arch/soc specific, and can gain
> > users outside of zram (fs compression, zswap, etc.).  zram's backends
> > potentially can disappear all together, if we switch to acomp crypto API.
> 
> Are there any plans for switching back to the acomp crypto API? We moved away
> from it some time ago and dropped all the crypto dependency in favor of the
> custom comp backends, right?

We moved from deprecated scomp API and switched to our own comp API.
There is a possibility of switching to acomp API in the future.
