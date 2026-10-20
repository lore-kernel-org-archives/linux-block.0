Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519369;
	b=PTKnqzSlMBfjMF150CcvKH4zxMNrt0gkXRK3ciPMEHJh1YRfN8KlIcr1yF24yIlDOAv3
	 BEnr0xo4aLium1qvimlzn+pZcPzLV/J7bFsVpijOsSMiOs4u9iwy725/sB38Nx2IZuGbG
	 qRR0e1NY/CqM3vIZG59+evhpbhVPpVVFuntYVd+I0pX+sZBygVIl+mGK/Azubmec0kpJG
	 VHkFj+M9kmUBlFPsEuq1Ytpr0+LCjDawTlWki+KmUZPZGileX92tZpTPEc3FMKCW23ZJm
	 MoAscXH0YlueMlSfnHgheVhDWIb2uSrs4dI+729RH1ilHIRMN18OBDBAeOgTX7A6RoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=avcM7OeAOA9Xi/3SI/gsoJLps37fRmICI7MaAi6WXEY=;
	b=mievqyqVEylobDNc5dqBgEpPBxlhdtZ/F4LpBh2ZYmUm1q4NC71iG1OOlW0iHhp8HVqK
	 do4jxzc52I8+47t7zGgV0f7kKIOh/U3n7Pm3bmPy1fMVaqHcYa6R7cQ2sIZPJX5jqmNUN
	 7SMxcnuZYz/o6yf0mXH+f3K0CM2Qh2H6gwCcV/ScyP9/dyN9Q7TFTJzTO+HC4m5sIPP8s
	 Guzi/c1I/bRX2lt90k9NZgfWOSlAmL2K14YqF/vgas+4eYiA99vtP9YUe4tfBaQzNeEef
	 UuAGko+j2LZdnmurmbVwUAobqrlNf0pKr9gmVk4a3N8opAAlNwtyrk6vR6J/LIHp+VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=e8wVzwOn;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9E606A31C
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 18:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D9E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=e8wVzwOn
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-188406bb948so770141c88.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792519368; x=1793124168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avcM7OeAOA9Xi/3SI/gsoJLps37fRmICI7MaAi6WXEY=;
        b=e8wVzwOnQPZkrfd74qmtUaU9b3PdCwX924N20xM8zCciinWuPoxxWJKjzYZvdkJY0l
         OUJsgik+1L0nSFMIBY4Bb3tyzjIvr4kPeRgUSQob2MvmTyz14WXva/UUUd+zmi3FXssV
         rlJGW5vaZpInwLHJ4HzTdb1S8hnMr4k+TrKNHRr/UfinA+DqdLntBhLH18h5f2dfIap2
         PjXuSbAOr/QYowX4vmqs9XEGRvMwe7gnJ/VsiiKwH9foDEit9j7gzcV/HxPJbs5uMnCk
         XrzwUTehR+0UpE6Q7HrcXUSiafT2L8356E9UKvcstkeJ3aPz1VJnQesVCrV2844VAk6p
         b4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519368; x=1793124168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avcM7OeAOA9Xi/3SI/gsoJLps37fRmICI7MaAi6WXEY=;
        b=F2Q5ZAIE9ieqKoEupAOpO58x7FVMEZXzr2NApQX9Ez2eRqnFFcjlB2LvMQArVrHijs
         fbatEaCbbwkevB4z3O+e+wtM+EvjAKAIm0Kgo0l7mW3FoIE0tvJxiqbWbICzPyyem6k/
         tIkbDaJtsd9yfi/rBgvPBxu2rcK81zs34z8OD1F3orOdMIX16xTJOk3cW+SzGqu9Sqqu
         QU6wiDuZRQYDA1UeL0bKbMs7Vp7A1HHpooqOs0CcjbtL7955xHfegRygm7h2xbI1CSNp
         BLmZWqdvT6X7/ruoZAXwN/xCpYzgrHrDV1cz9kqWBJkS74gyxKHFUxfbPnQu1DyHGkhU
         Izfg==
X-Gm-Message-State: AFq9FYIk2BflhfPDaFuzpHDC4bkN2gq4+eC4a8jJ3xLUhCgQWDcf9R9B
	C4Jv176V+QWriewK2AkS3RdufBMYuzE0P3vdciTZpXzhI8+rBJfG04kjvyCLRiVPgVk=
X-Gm-Gg: AYBFou31uvM5vh0p3coL/DSLYY7BLc+Pi85I4AeTWt++ixgYjbcVeAhZ7bR2mbOs74M
	YoL1J+itPLIUyiUKkb/hxrT4nQ82Xo93eAQTJ/uqC6wWxHtQ4GiYkwFQSYf3u5w89vuWuWAaScO
	uXkt5ZzdCsHayE0Ht0pNmuKdMZHxaE7PLwHhUWzXygzvmhLiEtPRtoBOFnvtENq8rFEAW8sh/NV
	g+4or4CmUH3JD7sIeanCtv1e08Ok0elZRfn3/SmTsR7V1DMb6cEGG5tuLwS8Qc9CnND5AH6f1ED
	a+Yn0g8bWTVZiOz77XLSJvStlQ5EmJeG90oKCpzpij21unlzzdC0b9jqFLS9fclzxhm08dmqP5Z
	bhUG5TYXZwRpkeNbP6flcf6WISs/xLjh1tnRbZhaSNgDUKs5/z09xHZ7YpUx2WBV9QnNVA3fjku
	qjHT5F9rl1PeF7BNtsjrm2YHHIDPm/D8NYg5YpSmvGm4ogVYnAmZneac+BRYSafKur68PpKlnpP
	l9EduD/2Wlo7EKprzBk
X-Received: by 2002:a05:701b:261b:b0:14d:3c0c:79e8 with SMTP id a92af1059eb24-1851160d02dmr17991943c88.10.1792519367321;
        Tue, 20 Oct 2026 11:02:47 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1903cce5accsm278639c88.18.2026.10.20.11.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:02:46 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:02:45 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests 0/5] nvme: detect ABA ghost writes on multipath
 fabrics
Message-ID: <20261020180245.GP2931-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
 <arOFG9-sM_GrrbQf@shinmob>
 <20260923170238.GH2931-mkhalfella@purestorage.com>
 <ar8eGV4jsEchjk-R@shinmob>
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
In-Reply-To: <ar8eGV4jsEchjk-R@shinmob>

On Fri 2026-10-02 05:03:20 +0200, Shin'ichiro Kawasaki wrote:
> On Sep 23, 2026 / 10:02, Mohamed Khalfella wrote:
> > On Wed 2026-09-23 17:18:21 +0900, Shin'ichiro Kawasaki wrote:
> > > On Sep 16, 2026 / 20:06, Mohamed Khalfella wrote:
> > > 
> > > Mohamad, thanks for the series. Before I look in the details of the patches,
> > > I would like make a comment below.
> > > 
> > > > Reproducing the race needs an IO that can be held at the target for
> > > > longer than the host's io_timeout without being failed. The first three
> > > > patches give miniublk that ability, since there was previously no way to
> > > > talk to a running ublk server at all:
> > > > 
> > > >   1/5  adds a loopback UDP control channel to the daemon, served by a
> > > >        detached thread, one reply datagram per request
> > > >   2/5  adds an INJECT_DELAY command which delays a given number of reads
> > > >        or writes as an io_uring timeout on the queue's own ring
> > > >   3/5  exposes it as "miniublk inject", which returns only once the
> > > >        daemon has armed the delay, so a test can start IO immediately
> > > >        without racing it
> > > 
> > > It is interesting to implement the delay feature to miniublk, and use it as the
> > > testing tool. But I'm not sure if this is the best approach because of two
> > > points. First, scsi_debug has jdelay and ndelay options. I wonder if this
> > > existing feature can fulfill the requirements of the new test case. Second, when
> > > rublk [*] is available in the PATH of the test system, blktests detect it and
> > > use it instead of miniublk. I guess the added delay feature is not available in
> > > rublk, and the test case won't work well. What do you think of these points?
> > > 
> > 
> > The two points make sense to me. Let me look at scsi_debug delay
> > injection mechanism first and see if it can be used here. I will also
> > look at rublk. Thanks for the pointers.
> 
> I've learned that now delay injection is being added to the block layer [*].
> This looks more generic and could be the best way for this use case.
> 
> [*] https://lore.kernel.org/linux-block/20260928221634.43239-1-haris.iqbal@linux.dev/

Thank you for pointing me to this patchset. The change as in v3 in the
link above is not sufficient for this case. Block layer "error_inject"
does not support an option to set the maximum number of times a rule
should be executed. I want only the first write to be delayed for the
test to be deterministic.

That is said, it should not be difficult to close this gap. I will give
it a shot.
