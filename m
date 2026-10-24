Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820920;
	b=zPxuxCop0oBh9guVuNB4X/7Cg502HvCi5UCwps90kCGb2+odhH5+Cmis5W919ZR1Lmo2
	 eDBOQiDpc2A0ceCpx88YaoK5CfRVRVgCPY9kaI2tAFMCaTu6QabxE2ETabZJDef3uh8Zm
	 2gCNpvPBPLTm1TUuQakj6GmekFx8I+XiNxwzLKabmat96tEppHPVOmqhRj/pyemH2uiU7
	 BGGBwuiapdHbJexWXlZ2lAqoR4DYOmOVs2CVg/jgnTOFmxU9osUyF7I9YDZB1xG6VFzQs
	 YhWXYv0vPVRKjP2TJ9JPadSh+HZkUDFEQzBgSjRS4/VAKgn5n3yCP1XHYDOp+R7gG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6D6lOz4P8rDJmxVCDMDICqLLJN650pwKHNbrX64l7+4=;
	b=EW0p9FjbWISGyXh/L5ocKXFwlxYTyfNxPvN2AUwpQE8vn7OFnajvuhNav7pJbrzR0Q3i
	 hbbiv1LLSTXBsRzXwov5S7glvz+G3rUQBycNkpKU7RqqpuulXVKtXe7Z27l7FfCm3Eps9
	 99nxDHmQEFDo/2TRJrAIB2gdcb7iaJ8UfxfMfWNJXuGKk1Dvl0N3XKOfZOX7Cb0YaT4Et
	 egdZyYLPBvAq6ual3xEujhvbO8Tqv9hn3liwEPd8WswevWhBpGKgoitWBaAgG17HOaMkF
	 +ghsVyMgwUCYQfXouD7yv80SA64i10cFvoYy+E1Lj1JHeR6IpqnMmtNSbrg+QWxbwHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MQ4Ux4MS;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8A606A31B
	for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 05:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED8A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MQ4Ux4MS
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36681e85e87so3860144eec.1
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 22:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792820919; x=1793425719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6D6lOz4P8rDJmxVCDMDICqLLJN650pwKHNbrX64l7+4=;
        b=MQ4Ux4MSSJOvA76JDEwDAWqrRgqKVRQdAX3P8Wm5QWhU30VvSBzD9axwGXhBzGaKqn
         lP86J1wRQKGBLRTy+Fktrz2yg8FaeBoxPDsk+XTgXUckb85JQ2DVRyxo4BIVLHaDDJKG
         RnpHBU3aJDq2wMlB1ROjdxoQUY5bbsoGv1fU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820919; x=1793425719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6D6lOz4P8rDJmxVCDMDICqLLJN650pwKHNbrX64l7+4=;
        b=yLPvN100XU6BGAqNfC7s81EawzxCaglI33wR4R7T1hNF9B/uf6AVWNhrhAzo469HRX
         /qQDbOnQjO7iYY2xxL3fdDv7IGfvTjOH7YyMiwFQJL9NGw1fDs5DQNKahtiliBeEPqAc
         Fv2MXQkZNE8pzUeZInrWqJfZZ+vzPQdVhobt3hWIDrYt+cTWuAdDcoAqJMRqMz2dGFzN
         VCz9tBXsMDAtdxwm0Jy511s78kziyM2f8uu/o2nIbRx/MC/sUg1RbnmAcUJs648/lYCq
         w3FkQTHvgfHKkxprBkK+wZt/gyE/Ei0kXl4ZYJFwjSqYmX5OVeo57CVmnDclfwsisYBl
         D2Mg==
X-Forwarded-Encrypted: i=1; AKwUvBxcAXYT/YhyR5E+XnQVLa5t0GAkkSt7ZgbQC2AmHMLPvsNCFY4wbyXd5W+DbaPjDNSTLj1tW9JTvoEZJw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbFX3UO/u21zuEBwALJDedmhDLwvsZx+Zc/2MKTRcuEk+823fV
	jGgsEu+GYFH2Lk2WPrYrQxSl/8vDXIJ2mr2YS3NJLK0LpU3KRZITtG/8HGwHWiowfQ==
X-Gm-Gg: AYBFou3+wZRjj5xk7NFJvYsclgWqrn7HPmXd2sBWdzLQArBuY/W0ddeUxMVUI7YpKQr
	r+c6gy59NkVBvKKrdjGNEnWZRfR91O1ALWAZhdY/7l0G6intyaq+/exh6aeH+ql6/O+NPGHA88/
	W1HvcJ+j+Lu41G+H6MrcQ+q6ZobxBxW24VYBTBYMspbPPvZP57NwSi8dXb8ybCI8rj0bkF9KL68
	QVouDgAyVJ/74ttEgOBBmEOiuu5VsyfJ9ucIxp5RUQk4HbRbNtNOEjAsgJcVgYNO+0lsHLA45D9
	gWQMPyFePFZdw+GpMCpkl5A6GXFN8pMNPG9sFOmud8EIcP6SOo3YNSIZ15zwlrWoSnkBCbAYKMd
	YHrbF5f9v1CDTocnZJQQkEHvHevuWqghmAdZGZQg3iD6wZJVtLrYic7fu5R+K0+Zf43uOBnbYCu
	qHGNL2h49VQ4phnwW0UD2Av9C8AanN7aZS4oiMgtErc9JJIYRgWE0RZXSRnU2NG4jNqXFLVLoOK
	SYUpBLZnC6m4AS+89jZRVD5CeLJngEqfvvEcUHIf/wPt9BzOQWUujwrzlXl6QLig+kL4Nsg2kvB
	9jvPwao+U4nUBtq9M2udXRMyzrZEP7wuzHek8hBnJQ==
X-Received: by 2002:a05:7301:2284:b0:369:1084:8ee3 with SMTP id 5a478bee46e88-369e848c506mr2557802eec.23.1792820918864;
        Fri, 23 Oct 2026 22:48:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:f7b9:fe46:772a:da49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm4221618eec.13.2026.10.23.22.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:48:37 -0700 (PDT)
Date: Sat, 24 Oct 2026 14:48:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Message-ID: <atxFgutP-N3UZex2@google.com>
References: <atrnvuQkeldgPqH5@google.com>
 <20261023114050.1011-1-hdanton@sina.com>
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
In-Reply-To: <20261023114050.1011-1-hdanton@sina.com>

On (26/10/23 19:40), Hillf Danton wrote:
[..]
> > writers vs readers 3 runs
> > 
> >     BASE+PE     IOPS 1,271k  avg 5.57us  sd 1,393us  p99.99 27.5us  max 1,581,800us
> >                 IOPS 1,461k  avg 3.43us  sd    78us  p99.99 23.9us  max   227,015us
> >                 IOPS 1,444k  avg 3.48us  sd   222us  p99.99 23.9us  max   592,628us
> >     PATCHED+PE  IOPS 1,457k  avg 3.32us  sd    18us  p99.99 27.5us  max     5,620us
> >                 IOPS 1,464k  avg 3.31us  sd    17us  p99.99 24.2us  max     5,621us
> >                 IOPS 1,475k  avg 3.29us  sd    16us  p99.99 26.5us  max     5,620us

BASE+PE looked noisy, so I sat down and tested properly (also tested
zstd and various compression levels).

(PE enabled for all tests)

######## zstd compression level 3 W-vs-R
    BASE     IOPS 1,154k  avg 7.84us  sd   444us  max   697,634us
             IOPS 881k  avg 14.16us  sd 2,242us  max 1,387,000us
             IOPS 704k  avg 20.43us  sd 3,499us  max 2,058,300us
             IOPS 563k  avg 29.02us  sd 3,910us  max 1,649,800us
             IOPS 626k  avg 24.79us  sd 4,013us  max 2,085,800us
             IOPS 976k  avg 11.54us  sd 1,518us  max 1,165,800us
             IOPS 1,178k  avg 7.44us  sd    22us  max     3,103us
             IOPS 1,120k  avg 7.39us  sd    21us  max     7,222us
             IOPS 522k  avg 32.51us  sd 4,311us  max 1,598,300us
             IOPS 581k  avg 27.54us  sd 3,626us  max 1,448,600us
             IOPS 1,160k  avg 7.69us  sd   352us  max   702,099us
             IOPS 1,169k  avg 7.52us  sd   129us  max   281,428us
             IOPS 954k  avg 12.06us  sd 1,705us  max 1,545,600us
             IOPS 1,029k  avg 10.24us  sd 1,156us  max   976,065us
             IOPS 1,169k  avg 7.48us  sd    24us  max     4,305us
             IOPS 1,177k  avg 7.45us  sd    53us  max   118,777us
             IOPS 579k  avg 27.43us  sd 3,661us  max 1,615,800us
             IOPS 1,169k  avg 7.52us  sd   115us  max   228,074us
             IOPS 1,110k  avg 8.59us  sd   985us  max 1,288,000us
             IOPS 1,177k  avg 7.45us  sd    29us  max    72,245us
             IOPS 580k  avg 27.74us  sd 3,755us  max 1,507,000us
    PATCHED  IOPS 1,179k  avg 7.40us  sd    23us  max     7,404us
             IOPS 1,179k  avg 7.41us  sd    22us  max     2,857us
             IOPS 1,176k  avg 7.40us  sd    22us  max     6,615us
             IOPS 1,175k  avg 7.44us  sd    23us  max     5,623us
             IOPS 1,176k  avg 7.42us  sd    24us  max     5,625us
             IOPS 1,173k  avg 7.42us  sd    24us  max     5,632us
             IOPS 1,172k  avg 7.41us  sd    23us  max     6,223us
             IOPS 1,173k  avg 7.40us  sd    25us  max     5,848us
             IOPS 1,173k  avg 7.40us  sd    24us  max     7,563us
             IOPS 1,172k  avg 7.42us  sd    24us  max     5,625us
             IOPS 1,175k  avg 7.42us  sd    23us  max     5,626us
             IOPS 1,177k  avg 7.42us  sd    23us  max     4,243us
             IOPS 1,170k  avg 7.46us  sd    25us  max     5,622us
             IOPS 1,178k  avg 7.40us  sd    22us  max     3,213us
             IOPS 1,167k  avg 7.43us  sd    25us  max     7,593us
             IOPS 1,174k  avg 7.44us  sd    23us  max     6,971us
             IOPS 1,179k  avg 7.38us  sd    23us  max     3,477us
             IOPS 1,180k  avg 7.39us  sd    23us  max     2,894us
             IOPS 1,145k  avg 7.37us  sd    21us  max     4,048us
             IOPS 1,177k  avg 7.38us  sd    22us  max     5,620us
             IOPS 1,177k  avg 7.40us  sd    23us  max     5,623us

    IOPS: BASE 932k (+-260k), PATCHED 1,174k (+-7k), 21 runs each.
          significant difference at 95% confidence: PATCHED is 241k (25.9%) higher; 95% CI [+136k, +353k], Welch's t-test p = 0.000
    max latency: BASE 3.1..2,085.8 ms, PATCHED 2.9..7.6 ms
          runs with max over 100 ms: BASE 17 of 21, PATCHED 0 of 21; over 1 s: BASE 11 of 21, PATCHED 0 of 21

######## zstd compression level 12 W-vs-R
    BASE     IOPS 690k  avg 21.53us  sd 3,088us  max 1,635,500us
             IOPS 478k  avg 36.51us  sd 4,385us  max 1,941,300us
             IOPS 822k  avg 16.13us  sd 2,865us  max 2,263,800us
             IOPS 1,161k  avg 7.73us  sd   114us  max   190,307us
             IOPS 780k  avg 17.56us  sd 2,717us  max 1,550,500us
             IOPS 1,166k  avg 7.66us  sd    40us  max    94,522us
             IOPS 585k  avg 27.51us  sd 3,847us  max 1,550,600us
             IOPS 1,147k  avg 7.97us  sd   344us  max   496,483us
             IOPS 1,166k  avg 7.64us  sd    49us  max   115,243us
             IOPS 1,163k  avg 7.66us  sd    23us  max     7,006us
             IOPS 1,071k  avg 9.42us  sd 1,489us  max 1,915,500us
             IOPS 962k  avg 11.88us  sd 2,168us  max 1,904,500us
             IOPS 607k  avg 26.05us  sd 3,538us  max 1,591,100us
             IOPS 1,167k  avg 7.63us  sd    23us  max     2,903us
             IOPS 1,157k  avg 7.78us  sd   198us  max   418,930us
             IOPS 1,163k  avg 7.66us  sd    40us  max   100,346us
             IOPS 1,162k  avg 7.70us  sd    32us  max    82,602us
             IOPS 488k  avg 35.43us  sd 4,340us  max 1,786,400us
             IOPS 563k  avg 28.85us  sd 3,989us  max 2,209,500us
             IOPS 843k  avg 15.43us  sd 2,490us  max 1,572,100us
             IOPS 604k  avg 26.30us  sd 3,560us  max 1,555,700us
    PATCHED  IOPS 1,166k  avg 7.60us  sd    23us  max     5,623us
             IOPS 1,169k  avg 7.58us  sd    23us  max     5,629us
             IOPS 1,157k  avg 7.67us  sd    27us  max     5,639us
             IOPS 1,166k  avg 7.61us  sd    24us  max     5,644us
             IOPS 1,160k  avg 7.64us  sd    26us  max     7,543us
             IOPS 1,167k  avg 7.60us  sd    24us  max     7,514us
             IOPS 1,160k  avg 7.61us  sd    25us  max     6,643us
             IOPS 1,162k  avg 7.65us  sd    25us  max     7,315us
             IOPS 1,161k  avg 7.66us  sd    24us  max     6,237us
             IOPS 1,158k  avg 7.62us  sd    27us  max     7,688us
             IOPS 1,167k  avg 7.58us  sd    24us  max     5,637us
             IOPS 1,165k  avg 7.59us  sd    24us  max     7,098us
             IOPS 948k  avg 7.58us  sd    23us  max     7,808us
             IOPS 1,166k  avg 7.60us  sd    24us  max     5,621us
             IOPS 1,166k  avg 7.58us  sd    24us  max     5,672us
             IOPS 1,162k  avg 7.65us  sd    25us  max     6,824us
             IOPS 1,165k  avg 7.59us  sd    24us  max     7,078us
             IOPS 1,168k  avg 7.58us  sd    23us  max     6,191us
             IOPS 1,170k  avg 7.56us  sd    22us  max     2,851us
             IOPS 1,171k  avg 7.55us  sd    22us  max     2,834us
             IOPS 1,166k  avg 7.59us  sd    24us  max     5,627us

    IOPS: BASE 902k (+-269k), PATCHED 1,154k (+-47k), 21 runs each.
          significant difference at 95% confidence: PATCHED is 252k (27.9%) higher; 95% CI [+142k, +367k], Welch's t-test p = 0.000
    max latency: BASE 2.9..2,263.8 ms, PATCHED 2.8..7.8 ms
          runs with max over 100 ms: BASE 17 of 21, PATCHED 0 of 21; over 1 s: BASE 12 of 21, PATCHED 0 of 21

######## lz4 W-vs-R
    BASE     IOPS 1,422k  avg 3.84us  sd   418us  max   619,495us
             IOPS 1,450k  avg 3.57us  sd   326us  max   609,723us
             IOPS 1,414k  avg 3.92us  sd   543us  max   879,815us
             IOPS 1,451k  avg 3.56us  sd   253us  max   503,428us
             IOPS 1,460k  avg 3.40us  sd    68us  max   135,825us
             IOPS 1,413k  avg 3.31us  sd    44us  max   188,450us
             IOPS 1,432k  avg 3.73us  sd   503us  max   844,228us
             IOPS 1,387k  avg 4.20us  sd   719us  max   961,827us
             IOPS 1,464k  avg 3.38us  sd    44us  max   133,675us
             IOPS 1,469k  avg 3.38us  sd    22us  max    65,812us
             IOPS 1,465k  avg 3.40us  sd    49us  max   111,788us
             IOPS 1,465k  avg 3.39us  sd    64us  max   174,040us
             IOPS 1,467k  avg 3.38us  sd    36us  max    97,821us
             IOPS 1,445k  avg 3.63us  sd   343us  max   671,026us
             IOPS 1,472k  avg 3.35us  sd    27us  max    86,795us
             IOPS 1,473k  avg 3.33us  sd    44us  max   138,096us
             IOPS 1,439k  avg 3.71us  sd   353us  max   619,815us
             IOPS 1,398k  avg 3.36us  sd    54us  max   206,815us
             IOPS 1,471k  avg 3.36us  sd    15us  max     2,832us
             IOPS 1,407k  avg 4.02us  sd   629us  max 1,074,800us
             IOPS 1,465k  avg 3.40us  sd    63us  max   158,779us
    PATCHED  IOPS 1,471k  avg 3.30us  sd    15us  max     6,946us
             IOPS 1,473k  avg 3.29us  sd    16us  max     5,618us
             IOPS 1,474k  avg 3.29us  sd    15us  max     5,615us
             IOPS 1,473k  avg 3.29us  sd    15us  max     5,625us
             IOPS 1,440k  avg 3.26us  sd    13us  max     2,829us
             IOPS 1,456k  avg 3.30us  sd    15us  max     5,623us
             IOPS 1,476k  avg 3.29us  sd    15us  max     2,835us
             IOPS 1,464k  avg 3.28us  sd    16us  max     6,063us
             IOPS 1,468k  avg 3.32us  sd    19us  max     6,692us
             IOPS 1,465k  avg 3.30us  sd    17us  max     6,834us
             IOPS 1,468k  avg 3.28us  sd    16us  max     7,268us
             IOPS 1,463k  avg 3.31us  sd    17us  max     6,480us
             IOPS 1,454k  avg 3.33us  sd    20us  max     8,418us
             IOPS 1,452k  avg 3.32us  sd    19us  max     5,621us
             IOPS 1,477k  avg 3.27us  sd    14us  max     2,834us
             IOPS 1,468k  avg 3.30us  sd    16us  max     5,617us
             IOPS 1,475k  avg 3.30us  sd    16us  max     3,884us
             IOPS 1,475k  avg 3.30us  sd    16us  max     5,692us
             IOPS 1,471k  avg 3.30us  sd    15us  max     5,616us
             IOPS 1,473k  avg 3.28us  sd    16us  max     7,014us
             IOPS 1,475k  avg 3.28us  sd    15us  max     5,616us

    IOPS: BASE 1,444k (+-27k), PATCHED 1,467k (+-10k), 21 runs each.
          significant difference at 95% confidence: PATCHED is 23k (1.6%) higher; 95% CI [+11k, +35k], Welch's t-test p = 0.001
    max latency: BASE 2.8..1,074.8 ms, PATCHED 2.8..8.4 ms
          runs with max over 100 ms: BASE 17 of 21, PATCHED 0 of 21; over 1 s: BASE 1 of 21, PATCHED 0 of 21
