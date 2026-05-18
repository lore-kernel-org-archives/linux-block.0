Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1FC480DE6
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109813; cv=none; b=EzswK8E+jvLGtVMaXg8Y3VFWrb9n8Pdtgs51AvY4VC6bIdKhU56G4qAlNU+GC/+FwJO58cPs4RcLKYSieA/PHJytxnD34A4hvErsofU1PtpMUphUlZtxGZxoDlx09NiVzE6WGW7MVCoDuOw2gPm5lJkSJmdE8X61hFC79DgiOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109813; c=relaxed/simple;
	bh=vHQoLvBK0vJSP8zEHCZ/wEmv7h7Y9qdOm9ncKPC73x4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OVzGOA5Tze8A8KQjeZnA5O9+Ax1r9/cORnO7gZNZltxzZM0U+mG/Of7OBXCuqS5YI75ojN2xBODObEs8PiD4Rjm/Wcnw2SIDyTLbxsomnZryBEPituI6PkraWIj2tm7ckrh2AGXQ6YWQhTnO4wuqwXp2mNiLwE33mcQnsCCL7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/4GZ0DW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/4GZ0DW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so12882345e9.1
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109810; x=1779714610; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LihdlTZwPrBGlEo6T39HTZqJ5dJNGRfg+7I+9uO1gbU=;
        b=b/4GZ0DWr/cwrgzh4ISm+zSKLqeN0XfFI9iZJnYN4iz/UiFDcEjENmbWVOpkrxzZMT
         bBlXEWNvq/ZfJfIjufxXTGeV9c2QycsCPg6i0r9B/X+5YGDL0Qrt2N+WeaPwLW7i7cgx
         4tXvOhIG3UlT6z4ZQYS2pezrj5dpf+1YhCQyjL83rpoJAHNh4q6/8hGySRdhbPmFQfsc
         WllLqc/l1t8W6Fff8xOGOFZJzBnjaKnNG/zpisEA5Ql/p+27OOUSghI0Qi9t7B4490By
         uG0XIKNTcHEGBU+B0lTwC4a0OaNwHxR/htVvZ+x+0GzgADF3YP+vLNO6bWC43byVIN2r
         YwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109810; x=1779714610;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LihdlTZwPrBGlEo6T39HTZqJ5dJNGRfg+7I+9uO1gbU=;
        b=ecW5cu/0YJuVBnsHvDKrLPSTWudIMrMr5NkDJljSMtAIFtJ5dUFmsVsX1ZwRDEwXhm
         IIhzMg85W4iZaGWA2KFQO7wi2gEOgchC3GQU1xHJufLMaxXweCWo38UuOCVgFA/Z3tCQ
         Yz70JsvzncyeeBXKXbp3uYJCSvLmqBYnfWUH5hN3L5JtmOX5HjA9hwZ5OQKuYp/sXskS
         DL4/9OOBgm0gUfR0Ubzrc3sTTnDVOMQeB+E4nTEi3aFQn5yFV39RHxPsagzqCZOReWIX
         cbtegLKBTnFK9g2Du2ZwdoL/eGBB+irWvAZwG+TnFOslGgJS1Q5XnRd4K97YhjuPZ3KG
         8tCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8z0qGqnwgtMjRiLaDLGFb7ckDG/K1gY5KBB0t7Qb3PcKLOvef/ya3ZKNaFxdxIhDz5VE9AFXebHNsRkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgSiQzQGAzWhF9FV6RQFH1zcQMxvcQHZtrvzi6jZIlaI8/If2
	6WOt1lMqBELi8It2sVXzDDL4K9LjtJcjAjCyu+jFLrpyvHUr5XMwWzUd
X-Gm-Gg: Acq92OHwWuSxvOsuIJokMUae02xpnEG9EEHAT5Fghzx42GV4HSwbWIyeNq13PfrnYVo
	kIL/AGccCa55tlRXWBye4HCIYe/3ronx9EObj44dp4SvSw8hZyLChz/9i0/FzNa/17JkpKWbHLW
	hGYt7XLmPml/JJXvQ2wN1s5x8oUVr22SiyLWm7yGwsxzxSVYMxx2o9U+gzKeN/UzN5xz8OiOOLv
	uZMrBXY3wEeenhyD00nojuXB4H776B8vo04UWCEAWeyerl05b5TKLuNe30gqgOYDLPHcVLt0D9e
	hkHx1q+xTvb1sm6Fb9qAv1DdQ+vqxeBOOf/AkCbBxC7/b0h7FBg82GVVCxef0IpZ4oXQygPMU24
	FZjSXNEKKNAK9Py32UaCWItA5uB8lqMR4oJ1s/oHMbIk5SDVdvjO73E7ixjN9smjII3VoKVYHDf
	UZSG6qD8pkwsKdoyGdrZVbLmm2eHynGw==
X-Received: by 2002:a05:600c:8905:b0:48e:89fa:9811 with SMTP id 5b1f17b1804b1-48fd6361dc2mr240799145e9.13.1779109810232;
        Mon, 18 May 2026 06:10:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm36712452f8f.16.2026.05.18.06.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:10:09 -0700 (PDT)
Date: Mon, 18 May 2026 16:10:06 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [bug report] drbd: allow parallel promote/demote actions
Message-ID: <agsPrkfvl4VcjUc1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ This code is 12 years old.  It's weird to me that no one has complained
about this bug in real life but I suppose that unless you have kfree
poisoning or KASAN enabled then probably you wouldn't notice it. ]

Hello Lars Ellenberg,

Commit 9e276872fe16 ("drbd: allow parallel promote/demote actions")
from Apr 28, 2014 (linux-next), leads to the following Smatch static
checker warning:

drivers/block/drbd/drbd_nl.c:4564 drbd_adm_down() error: dereferencing freed memory 'resource' (line 4562)
drivers/block/drbd/drbd_nl.c:4585 drbd_adm_del_resource() error: dereferencing freed memory 'resource' (line 4584)

drivers/block/drbd/drbd_nl.c
    4552         /* delete volumes */
    4553         idr_for_each_entry(&resource->devices, device, i) {
    4554                 retcode = adm_del_minor(device);
    4555                 if (retcode != NO_ERROR) {
    4556                         /* "can not happen" */
    4557                         drbd_msg_put_info(adm_ctx->reply_skb, "failed to delete volume");
    4558                         goto out;
    4559                 }
    4560         }
    4561 
    4562         retcode = adm_del_resource(resource);
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^
This frees "resource"

    4563 out:
--> 4564         mutex_unlock(&resource->adm_mutex);
                              ^^^^^^^^^
Use after free.

    4565 finish:
    4566         adm_ctx->reply_dh->ret_code = retcode;
    4567         return 0;
    4568 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
