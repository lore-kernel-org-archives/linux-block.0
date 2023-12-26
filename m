Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268C4F89F
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="18ryiROH"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7ba9356f562so30672939f.1
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 08:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703608132; x=1704212932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqKULS0YMcmuvyLedxribgSRf7vDbW80hT925dXaTP4=;
        b=18ryiROHKRNYI9byU9Lt9QYcmMxUQZqtwpqEeSwn5khgD9Nn47vwa6jtBvi2JBl7c/
         rDH6dXcXo0hPsMsrzSLh7op9rw1SF1rRUSSDlhflCYHBwiGsY7BdU0YEmVDAu6ZlnHmn
         TPz3tQwFg4D5YA5Cw0YW4w8uR6cJZcYtExs/iYxwSEg267nYBXTm20gUxyRdUlLCCBIM
         qNHeQehw31LBoWhhB49LWQnlH8y+FHkTKB2XtRLa4FJZ+053NqWq67F3UI4DfCKAKvXw
         JeOLgEa6M4ioj/et0w4bohHkZ/NM0se5J63Ol0zMQ/c279hPmmijcputkCJPtNwuUnYr
         31Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703608132; x=1704212932;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqKULS0YMcmuvyLedxribgSRf7vDbW80hT925dXaTP4=;
        b=ijNqFf+eHnaPWsigi/Kd9fEan1Fiv3XuHtUoAfBab0Ks10jBSNXPHH8WX6+wr9kf/6
         MF3V4JF3RxFfSzqUPMG/xWGj44AeSbh5KOnpJVto8Se6KQAZtjJ1t16cqrtUenLlZ6q0
         4cI4oPmleO49OfhLEjn1kj5bNwcNS9JpBzqxkn0IEvhoQp05yQwig3cCRZzVMfvfLs9j
         7bZj5kHYddFlRfampPRNg72wi3vRn3iFYEUXI2lvP/oRHf9d7YLCsDhk/PNY9yp3dgDh
         7lHFtUNxIOOc5Ta5MQdndaCZRS51FEJklc6NjVVLXbzFpAN4hELgh14FANOMgFSigdoK
         z46g==
X-Gm-Message-State: AOJu0YyZzKL3JoluS14VgeALPcEAh7V+gyCIMvxdKnjYcoa1P88PIhLA
	dbrGXW59NysWvZCr+8bOckdAh4xL/k0JSOsoS9APC8VZc2dFOQ==
X-Google-Smtp-Source: AGHT+IGEYfzUbf77j1iWWMZaGN2zvec/K39Uhj/twPD3wgHr5O9JMQVELLZT5iuAXWiGpFj4JofV3w==
X-Received: by 2002:a05:6602:179e:b0:7ba:c855:9cf7 with SMTP id y30-20020a056602179e00b007bac8559cf7mr4939800iox.2.1703608132137;
        Tue, 26 Dec 2023 08:28:52 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i17-20020a02b691000000b0046d18e358b3sm1607879jam.63.2023.12.26.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 08:28:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20231226090747.204969-1-hch@lst.de>
References: <20231226090747.204969-1-hch@lst.de>
Subject: Re: [PATCH] blk-wbt: remove the separate write cache tracking
Message-Id: <170360813078.1227834.4016532820153740695.b4-ty@kernel.dk>
Date: Tue, 26 Dec 2023 09:28:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Tue, 26 Dec 2023 09:07:47 +0000, Christoph Hellwig wrote:
> Use the queue wide write back cache tracking insted of duplicating the
> value in strut rq_wb.
> 
> 

Applied, thanks!

[1/1] blk-wbt: remove the separate write cache tracking
      commit: 5d13243820c457edf54a1fd848141ce7eb092671

Best regards,
-- 
Jens Axboe



