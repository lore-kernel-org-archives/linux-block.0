Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B7188580;
	Tue,  5 Aug 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401128; cv=none; b=UhWCHrvtqbPHvAeBck0osk1Pd6o2/+3RrZwLjAYcV1Byj7rEdnzkR5CGp60dwt1DsDngiOWt17XaB9Nkyv6FWWdZSeAjyvcDFV63kBaSgQ3h8FL3R3E8Tsi9of/lQRjLaeRjWXSCTpLpiVpuprJ/KEGoMP/hph6AyTyK4cgje/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401128; c=relaxed/simple;
	bh=+7/ByOKxDDWiv30LoFE8yfggFhVUZwypBp8AFXeN1eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2T5FOTyDqcyrPouWeAftJmjIAznJW5mZ8+SI2/5sRG6VEI6i7ZhV/tB8UzedwQbYdogNRleZIIMdJlyBJFoCuR1cxHqlrR44BQPv0+HR2rpKZAS3wi6bEnKgY9HjDuRv+nwj9fuSTBlAsTJrLt6j4vFvkAUHWQO8ljf8Yoj2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu2k3j53; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu2k3j53"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e2c1dc6567so270736085a.1;
        Tue, 05 Aug 2025 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754401126; x=1755005926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7sx6UhdwFf/XGs44w0LtzcSKpKLbsrW90CtjKNe1K4=;
        b=Mu2k3j53VQOzjpIKgBdIdvSjA1hsb+6AxypdSHFD2Ou5gRML0BO+rmIDJ0c75qQHLf
         ne7iiabsxMnHNgJkEY1E69G0s9OdS5QxF6C6YmxP51gp89qsIETzZFzLofleObl4kIpm
         4iVS8eOhfLaNcfbu8vj4E/28W6if5RfGaPQQ6kWm84RpWNAfjie44Zom+atIJ7A47wop
         P2VWb21tJSpY6Eon9mIYAvXEA7qSjC/E86gnaH0WAxZOVgfoTDIyJaImq3etcv3+tbGo
         9uc6MB3xnlSnxeXiQkT8A4w59A0TUmZtcHjlso5x1bgusYRsnNIJt1qOIQZZJAJ6yOt1
         yQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401126; x=1755005926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7sx6UhdwFf/XGs44w0LtzcSKpKLbsrW90CtjKNe1K4=;
        b=ckg7pj4wZiCuq1MZ+LgGzVKaybPIfJESpfPiK2wvi4FsSzzbicejVjkOevOEr3jb91
         TkDD/6tfuwRWB6t0wlKm2ZL1uDm5+zBhIGsTx3GRHg3r5ZlVSHHmINCnbpvmyAGSRo9Y
         6jCYO4OYq2Mb+c280EQd9kk9906Zil+r2qP2e0GhUH+kAyLeK2o6CzrCrknc+y5F7WON
         JQEj+2pw2TAs9Jsgyewrvlyl4QNO9yJtDDHIZUucRI3OMtuKNs0zqU7Dw/+Mwt01jk3p
         HonYIdWaiSjsb/VponMKY6v8HVp6RzsWPWw3VRc6XtVItkQkshn+CjR7JtxUpADukeB1
         oLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF4JgpAITlVpCg3jskm2m91++A+PVIyn2bhsOpW7DSlL43c2yljQp8n3CPqqprCZTUirSE3W9505bPq0QJ@vger.kernel.org, AJvYcCXli0g815BDh02zRFgiyvd123gDv/iELg7e8oW8OuB68BbsHQv6V+/iIudbwp2b43YK/EEOuXLQo6EgBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRA3KZGd13uZQJKw1J8gdfYNcsO59UtDkI1JIyg+LUhVsavDo
	HHiwxq00kapag0x+x0iZQeD9D39uHFog3vIckfB0FtPNsyKXF+UaDLZU
X-Gm-Gg: ASbGnctSS845WM1d1cm5zFMm9CEGRWm9MaMGANLhmqab/PU6/ee3usE4DodZ9qKu2gw
	NwlRKpfdNjwRNJktYmWIbScUh+oOL2RUDEsdjAKaU2rwP0NpSSbpEsrongQUhE13UcWuOX5Cyib
	KV5RjbzwqxyGLSbdh8a7lNtFdTnOxZATeekJQvsnd25K4vE8U59dTaSzsNbkoWRI3Bbkw8jtgl6
	cI5A1i/SAbNlxxOq+dJL64FDSa8Bqni4Ja5ZoYNb1B7mKxBl4Gy7FczIv5gf98mec/Gj6SfBJfL
	dmyPgp2FdnhZeNJYTPu/+es1McyOYBaLz0NmwUId1SgXbCvFfpW5eBdvILrlbN8k5iJj5Piw9qJ
	DzvCp0RGXYdpTy4q+TQ==
X-Google-Smtp-Source: AGHT+IHe/oe0zY4+yYJwTiGmWWmGZRBDTEEyCDbeD1Lc63F0pgqbtmUw5hk9yo87sF0JWRa+SalrIA==
X-Received: by 2002:a05:620a:1706:b0:7e8:b6:ceac with SMTP id af79cd13be357-7e800b6cf45mr1153789685a.53.1754401125936;
        Tue, 05 Aug 2025 06:38:45 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e8050b6101sm194923585a.26.2025.08.05.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:38:45 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:38:28 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
 <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>

On 25/08/05 07:22PM, Sergey Senozhatsky wrote:
> On (25/08/03 02:25), Seyediman Seyedarab wrote:
> > Temporarily add a NULL check in zcomp_available_show() to prevent the
> > crash. The use-after-free issue requires a more comprehensive fix using
> > proper reference counting to ensure the zram structure isn't freed while
> > still in use.
> 
> Not without a reproducer, sorry.  Per my limited experience, attempts
> to fix syzkaller reports w/o reproducers often lead to regressions or
> just more problems.

It can be reproduced with the following code:
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main()
{
    int hot_remove_fd, comp_alg_fd, disksize_fd;
    char buf[256];
    
    system("modprobe -r zram");
    system("modprobe zram");
    
    disksize_fd = open("/sys/block/zram0/disksize", O_WRONLY);
    if (disksize_fd >= 0) {
        write(disksize_fd, "1073741824", 10);
        close(disksize_fd);
    }

    hot_remove_fd = open("/sys/class/zram-control/hot_remove", O_WRONLY);
    comp_alg_fd = open("/sys/block/zram0/comp_algorithm", O_RDONLY);
    
    write(hot_remove_fd, "0", 1);
    
    for (int i = 0; i < 1000000; i++) {
        lseek(comp_alg_fd, 0, SEEK_SET);
        read(comp_alg_fd, buf, sizeof(buf));
        printf("comp_algorithm: %s", buf);
    }
}

Which produces corrupted output sometimes. (it's a race condition, so it
doesn't happen all the time...)
