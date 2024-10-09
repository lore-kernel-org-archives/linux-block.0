Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BB13A409
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508284; cv=none; b=ALOip4O970vvj9o/fyFRENLBEOoP0/7k1KBt9hbc7u319SKngFr8uQzPK8+y/mOPVHHQtHdMMxcRWP92Y22cc3t8DkXOTrhNFRxCfdPhMI1gSudwaQVXSDBSk/bjLHV7Frwea6jNsyu81zgtD4ST59Ro47U/SwqloFXHGFVWA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508284; c=relaxed/simple;
	bh=1hw63DUAjqIMFMjnGujUf9yv1qqi8z1TJ0sRZkH2FA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwZ2npP4+lYu98KhrMIB2Q2f5rxCm4H+ITOIrJSIS6KuExsbD8GKH1K0GXFQT4n/sJ51iRdq37qGqwohhcOieYKAumlZ/jRpYrhSpOfy+kJMc3gUFFgj4DTnqrYORwXvBu8x31xeQN1LSPNlBf+W9coVueZ5rngJmLYRce5b2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RrrdI76t; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RrrdI76t"
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-a994c322aefso250443066b.1
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2024 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1728508281; x=1729113081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mBmd12azNSR7lVUkOcMUnPjRKc2JspOUH/AQ8/JrkQ=;
        b=RrrdI76tcq6rb3QepTs1JdLLyjh/quMybc+0IPFvTkFBgoMyvlSozf4vCDGyPorgZ9
         j855/W7aVYK3FL0jsQg43p/IAxOVozFXQz9Ug/R4+hjYVtfT7ov/pxIq5VseamUIBZL6
         WY/Mtp4fHO5KK/MyajNeT4vJWAMPAKrdXqqFPRLQ00pXvHOxZroH7JHve0gf+wTN4sOW
         z7MgYwgoa19MDALlwURTFzTG9IjWRy/ea9dxB6p/ac507tnMhLyuLWxvvYuDZ5uHj+nT
         tp3juMPiAalXf0ssduHC48t9h8a+CqKEClYxEPnN4A2R+Rdr+iWba135K/UwXo8FVNY1
         VOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508281; x=1729113081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mBmd12azNSR7lVUkOcMUnPjRKc2JspOUH/AQ8/JrkQ=;
        b=BJfqBelxYZDtDupHFhi5sMzUIj1AGJDTh2ywj9kjtGEjVYThMcQb1D0VOFUxeE6X/5
         P1a1lFLryWL/oK/oepqJU6GkNUKJu84k3//ghJnKs4m8735pSQ1Snk4V1TOYfJudlYc1
         qkPEXX5ZJsG8zDTLtkqAvbotDOAgnBy4Quf6rpcnYeW1P6DsZuyJVp1qAfBr8E8O95n1
         w9CwbSi7LILCRsoKOCPbW+kH/uckzZ8Rmy0LAXIAsBGfbMankLKCAaGAcgCY/yw0HntT
         iQOub8x1Jq6y6QBacXWIwIFz3+NvPM4uCnxYECtw2+ACYJlvwwb6hex1s1LIyFLFxscl
         J1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5VI5EFvLlxtaRhoYIxbphAD7qk/VJ5K1CFAl8HpMGfP6lcXHtstM2nGH3ysFPVhKAEPKXjBB1hpAp5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyVlnLB/H9NI9tajhnhvGCsfLNIFgUQhUwjtMZ0ZWJAwiFI5s
	jTnfrDrrT/cyIlvOuL0QMjMkYXYAg8ksFx/fOSECeM8ZU0Ib9X3GUbl/Q9VLl423xpwsef+HDVA
	Eer9vo6cFzYYhb1BBppKq+Hh9NO9UUFoVblVsPblX8X3QVUH5
X-Google-Smtp-Source: AGHT+IHG7T2YEPxrL/MgmbWXuz+M4tnzTDpS09XsfjnqRppw18xkWccA1MVbg1Hwdi29Xt8glVbOcjb4Zc7Q
X-Received: by 2002:a17:907:1c91:b0:a99:5687:496 with SMTP id a640c23a62f3a-a99a13d89f7mr93186966b.30.1728508280697;
        Wed, 09 Oct 2024 14:11:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-a9968125a76sm9258266b.116.2024.10.09.14.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:11:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 597ED340269;
	Wed,  9 Oct 2024 15:11:19 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4E90BE40E87; Wed,  9 Oct 2024 15:11:19 -0600 (MDT)
Date: Wed, 9 Oct 2024 15:11:19 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: decouple hctx and ublk server threads
Message-ID: <Zwbxd0947cRh7NyY@dev-ushankar.dev.purestorage.com>
References: <20241002224437.3088981-1-ushankar@purestorage.com>
 <ZwJWRSBnH7Cm3djA@fedora>
 <ZwQ7cQPSiUlmEGZc@dev-ushankar.dev.purestorage.com>
 <ZwSPO4b6rccVVx-H@fedora>
 <ZwSU1yRc0e6ipehp@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwSU1yRc0e6ipehp@fedora>

On Tue, Oct 08, 2024 at 10:11:35AM +0800, Ming Lei wrote:
> Forget to mention, `struct ublk_queue` and `struct ublk_io` are operated
> lockless now, since we suppose both two are read/write in single pthread.
> 
> If we kill this limit, READ/WRITE on the two structures have to
> protected, which may add extra cost, :-(

Argh, yes you're right. Fortunately, ublk_queue looks like it is
read-only in the completion path, so we should be able to get away
without synchronization there. ublk_io will need some synchronization
but with a correctly written ublk server, the synchronization should
almost always be uncontended and therefore, hopefully, unnoticeable.

I'll see what I can come up with in v2.

