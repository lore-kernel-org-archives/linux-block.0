Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018061;
	b=c1J/iN8eYsXu0sDqnjCZdbfVp9Y8LFERuTFan+IrNenKuo6jBy4WXvjWj0esBOgiVxms
	 07LFHWirtBKocIs68Zbip35e73oKSQNeL92Zf4Hd6goh3D9zvCDPusfQPVscKEpE3Y2M5
	 Fql0DRVyFp/hhkCsPFx3rpOJhLcMLTpK3ByJQOX5jy4SmcGu5AtxGvBGEiYoNbFveloqC
	 l6idknVJRq2rx6s/K957Zm4TH1zXfSeSZOw0N82YAuVeGNkimNGmQq05V4/x59URpbnEg
	 B/c/0oPtp4ObFdShupKc0UbVJonH1YiwCYnzeFzFwwvlCAOTnRVOvQZRtjpPA6xLo0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=ujkN+eC6Zu+/+obGmDVtyoxxt+WJSJZ0U/kWRfaBMgw=;
	b=ydlDoxiFfJvuo7dAj0vuSzB6fqzfkyUrIWdQVmM8WuSXYz5LK9v1NELzuaYrss3BpAX+
	 4gu4Evfc3lUZiy/tpBQLDU98q3oTAYNwnVURtyDGzfICFyUscTSIPtWHdU79zg8QlRHX7
	 b6XD/oGegktYPg1Em6YCxyaogOyP5XOlqUjXyR+UT3T+/PpV0oub8Pywa9HEGyTLJrSNo
	 48mCWFv1Mrdqz9+CzO9LxEAZ7ncLL20Ok+gVeMwTfsAVMiSBkNDmWLhFpSnaAmxxr7q7J
	 LAWCjxLH9k1Z4C6RC9PZJDxobqh8oLuNa87R0cD2vgrPwwaUzkVxRWwINmwVyoDFVgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WW6ACKA7;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD860A260D
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74FD860A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WW6ACKA7
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-717080a2d50so1023465eaf.0
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018060; x=1795622860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujkN+eC6Zu+/+obGmDVtyoxxt+WJSJZ0U/kWRfaBMgw=;
        b=WW6ACKA7UVZiX0KfAzzg+edxiER4uOGUTJowPB7yetEcRNF0o4/Kgsp9BxcVCXTdif
         Tgv4mmpcq1Wmrf7KxcoFOWJZbPQfmjFqlCYt+veaAJCLfJJpjJJ0+pe+WJbg9pSpDyX4
         hEB4mBStC6AtALo5N6bjSJ5/23Si3ahmHjbu+4GyrjanqO9Z9FQL7hr4Y+i5Dj6ojLaN
         f8kgHBRGEQ82u2/SnxNtKDHtkRKPlhx5anbGuZ15xZocj+BHbgcKoOetIUpg1RZEvvJo
         MQ27KN1ViJofCC9c5ILfBA0ZvkCbNS1QGKsj6P7llq7rDd/KfASgsSuCATFnW+exUF01
         J99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018060; x=1795622860;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujkN+eC6Zu+/+obGmDVtyoxxt+WJSJZ0U/kWRfaBMgw=;
        b=ag9QeXbp95ZJnN5N67QcKs9fhoJiKQnf/WI8dsT2Z7xPPua480OKnI0dd+TkNIz3/g
         cPKg+1DA7W/DUEINGyFl40EE8waT63Nec0LEkIKe+KXsOzog+dGVeVtObyVaJK77wpjR
         CMZs95DfUIHE8Ye8n+W75dF0Y6MV9P459FAV+aOB8AaMPmi0W6fHVrjMj/CuL5ZIWE6s
         gY8+qM/akwTrJOvyKneV0S5xYuBNTh2GhPd9ROR3PkE+E2uPtr0v6eAJ7kIhUe+2n+/C
         KG6gEIkZD8hcDOyiU9qZ64XFrd6DZOXc98eN2lGKEPxpklq/ggNgsYNtbWybiu12K+wX
         bLJw==
X-Forwarded-Encrypted: i=1; AL+hErHniEhosqfEL9XF4C6eXvzz6lHJEJzMZgNrzky5I7b7iq2JXonAWkMD1B4DEDzzQ9bqPLAQXp8JkJ81sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Tg1qLwsJQ+Th2+GC/FxAEOORo9XQpWZMghtgBStXTHj9ZRqke
	cdQogr18VqkEE2v3O/RQXd+Be7ReCaOBwV5Mvbzg+nRi36SgNRlen5+oT6pB4Y8+h/g=
X-Gm-Gg: AYBFou2bYIGiVMZRP/rpBxVYs4rKKMOqjJs46JBqSDmJBTAxtCkehopRYs7QbRuDu82
	c5hA5np/51Mq7sYsROtyuKFTISuF0HW3z+0NaQx4pdmXROKvTZF6LU4Gs5jcvHulK7toK106M2w
	FsnN0vaMaPtWVn59Bq2dWOkXLjNKQvOmTuCMaX8kidn0D4Xl+GPAgl/wld/ZmCG7DpA9EScI9Sq
	yQ6MWav+gTf/NnvCplXaaXgDci5KiF9smbacold4fR/atB2puhBrjObSUL/RBaKqQW2FRN5AM2o
	QEgPaDIIT5eAriY9YJrXJWFk4czz4HWxhb09L0QhJ54FKEUHAnWK4QTTOVdZiWNOhPMhCmctL1d
	9vzrZ67K9BsXXEAz3C7ldUN+cwrIFpXAOOR6ZRtdiktnuiSGD2ppb8EVMY2A6D4Tt+Rr9ngeN9R
	3SXtT+e8q28HJeSPnc0aUPusrK+WwdGMgUhk1jO03VYuduECbX9gzcfqYtEX1kwjYLoFXySLqf6
	xFf+xCdmbDbyCRbGUe85IwfHQXXDxfXoc702SrlAmbX1ketcPDGpS8V8gddHpGcHlGuE2Q0o2Fc
	+YIOoWifJ2oCMHa31pXOJAUfMSA2zPpNxie911Q018to74PLzdg9TkY71SplgTOcRVDS/Efovbu
	LSrUpr2rqIjMSuqj133A0BFkQw5Cf0fGE6EoTjd1dHN3nP/sVilDus/XTJmdSOR3amRPYVDoG
X-Received: by 2002:a05:6820:807:b0:71a:fa06:4dd7 with SMTP id 006d021491bc7-71b18454b50mr2463359eaf.28.1795018060423;
        Wed, 18 Nov 2026 08:07:40 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tom.leiming@gmail.com, shuah@kernel.org, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
Subject: Re: [PATCH 0/4] ublk: report recovery test failures and fix the
 exposed defects
Message-Id: <179501805884.17649.3891543607346842206.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:38 -0700
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


On Wed, 11 Nov 2026 22:57:52 +0800, shao.mingyin@zte.com.cn wrote:
> The four patches make the ublk recovery tests report failures from their
> workers, and then fix the two defects that the stricter tests exposed.
> They are one series because the later work came out of the earlier
> patches: patch 2 applies on top of patch 1, and patches 3 and 4 are the
> two independent fixes that patch 2's testing uncovered.
> 
> Patch 1 waits for the recorded recovery worker PIDs and reports their
> status from the parent, so a failed worker no longer ends in PASS.  It is
> a v2 of the patch posted separately on 11-09; the only change is the
> simplified wait loop Ming Lei asked for, and his Reviewed-by is kept.
> 
> [...]

Applied, thanks!

[1/4] selftests: ublk: propagate recovery worker failures
      commit: 6f3393515ee6526cf66175a85f3327899db765e3
[2/4] selftests: ublk: propagate stress worker failures
      commit: 01fe9c1894fc4cce7b04cdae5522c86519ba835e
[3/4] ublk: cancel commits arriving after the quiesce scan
      commit: b79225a8965f80b448dcdd236da2e1ca0690238e
[4/4] selftests: ublk: clear reused batch SQE command flags
      commit: 73f6a1d93040ac8cbdb03b3702a66e6a14773d02

Best regards,
-- 
Jens Axboe



