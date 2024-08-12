Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786616D9B8
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480256; cv=none; b=ZblCia7Hg2U/ghgLGUqGD3VImfM59K+EMq+tIH9+D0TtWKkIqBtX3R/h6YHUZ8V4Mdnl+/gZtnOYIQL1SEsj/4vhlqTmM+YTkiGauohclUpdEIKOtv43ghqRa/6J56TQ+NGGnepLQKLbfWJ0Tz1s+/EijuE4+9kXmfHUcGYv89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480256; c=relaxed/simple;
	bh=ScOEx0xVvekqkJujWLlawmZLGK1li+m0K4GL21rpF4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DApiovAZiNWjSJWBgOfrAzIOg4Ax8UGWAZp3TubF2dec06N/sxgfEVveBjEMFFDuSBzcU2lgWVH4shS0skXbsMxWmrsOHZur+/0E4NntKDiUeO1xcfVNOtZuRrPaWjYb4cUg3o63BiSy3VtvXt8atFMzP8duBDKtQD27yH5x6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GZ5jW1xX; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GZ5jW1xX"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c2595f5c35so743234a12.1
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723480253; x=1724085053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEQ0kZ1j0xXriKAqCkiJ8y0e3LfiJ+64DCaxa9YmyWQ=;
        b=GZ5jW1xX4V/funmhP9T+DZ1qKp+xlSCFr8sotqMlg6UywbzBlNTouQUnyRcMjHZsxl
         XzNXzMNnoA2HhQf7reCwRlkLpx3W1l0FJgdL866apysYBXnVFc0KIIxkQ+yhx9bs4lem
         aVLr2LDj1/TmZ77K4Fvgf8R9EUKXRLHaPQzvS8ZiPcL0UkzJvf+yGXfyXmbgN5SD1W/H
         1LkVKzqElI+8DkABhZQNIPaTBLiXE++Ja7W2y495WiOoJQ4g7VO4x23EKYN97A3KmSO6
         F1ZSADQKls7bisHOawi4ZzhPKRhmIXOEItY+l7Rv2y+BaVHWdeC2rJHKtqdcMT2Vv+ms
         cLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480253; x=1724085053;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEQ0kZ1j0xXriKAqCkiJ8y0e3LfiJ+64DCaxa9YmyWQ=;
        b=df8lNz2T0xOw3EkpaIRfAybHDFuvaMq5JBjjNlzOAoH/gOlZ1qKeAVGBl5MgDQD459
         uY/vo0L8SA9wNOqgFUMcLRcD9KEa8FUL/FNrDlbCZC7Q1FhssUEmtsJS1kuUO92pniH0
         gPGWWJhdEC2Mrmrm5Uq1Emz3xkD/q03zHtDIShW0JpJiCe7VTdjA7vqEFplJW/AHA+1S
         GAHcUvPttMMA8cjYWHUqMVpJ5DJ9wTRhjPQpEJT90AhQychGV155prYcFAnIdo+YvP4t
         Ya63yd7VNzahVDbzr/TamjsYhX5ZMvHu29xDjrbuk2qLRyUBpJrdOqPbsALAB1E67eEZ
         1VPA==
X-Gm-Message-State: AOJu0Ywjv4/ytq4pmFGjZKqBdZtuiiBiXvr9IbxY575MVAYGt9d4BkUp
	MnYIe8+ZJPyRdh2iZF67/FgsOKc9eeSicN1WWB+fWE5iaJndjmBBLwCFgDrDwzQ=
X-Google-Smtp-Source: AGHT+IEYGOVPXKOGA6Bo2BvJxazpSOdLJOE8A6bkqFjiMLOroXnqB2RROohXo3CZJ4I7Lh3JEMC58w==
X-Received: by 2002:a17:90a:c90e:b0:2c8:e8ed:8a33 with SMTP id 98e67ed59e1d1-2d3926ae745mr482884a91.4.1723480252631;
        Mon, 12 Aug 2024 09:30:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c9d745sm8559990a91.28.2024.08.12.09.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:30:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Andreas Hindborg <a.hindborg@samsung.com>
In-Reply-To: <20240812013624.587587-1-ming.lei@redhat.com>
References: <20240812013624.587587-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: move zone report data out of request pdu
Message-Id: <172348025170.92046.7882751296981368824.b4-ty@kernel.dk>
Date: Mon, 12 Aug 2024 10:30:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 12 Aug 2024 09:36:24 +0800, Ming Lei wrote:
> ublk zoned takes 16 bytes in each request pdu just for handling REPORT_ZONE
> operation, this way does waste memory since request pdu is allocated
> statically.
> 
> Store the transient zone report data into one global xarray, and remove
> it after the report zone request is completed. This way is reasonable
> since report zone is run in slow code path.
> 
> [...]

Applied, thanks!

[1/1] ublk: move zone report data out of request pdu
      commit: 9327b51c9a9c864f5177127e09851da9d78b4943

Best regards,
-- 
Jens Axboe



