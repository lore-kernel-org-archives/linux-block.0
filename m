Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79343C043
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921666; cv=pass; b=EAhPdkBSokfM8u2hamXORsXWVs1W4K/WWGhJ+uB3GAgQDOqKl2Wpu5D/wRdM92+aCrmMm89WRvA80AlfABAoy2XN5FDROOQQj266OhMhditE34O6CqbY1ZDyZhgc6dmpW43oUqpnal36zk64S0UJ0HIAeQ1wIeyMvRnklffIThA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921666; c=relaxed/simple;
	bh=avM/l9BU5JWE8PpCWk7n6bBHBFYjehL3joo4vq+2G+4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oa7clhHoycUTgM3kqsdII4J6MAQ6USTzhOqq2qeC7DGRKpnwcohysGN8zU2Z8BwTBbAHCVXXw28cuiKSvKZMMOEBcvyu8qXjNDQdSGtGhcFrLaA2XxGtjdGRVnsdoIbZPDcctouhASsr8MSP6R9Tk2SL0XobliS/wNxDi29Ogc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjdqwEVt; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjdqwEVt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so30752425e9.1
        for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 09:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789921662; cv=none;
        d=google.com; s=arc-20260327;
        b=TRw1X2TyHxTAtk5ldLSA4lNuZryqdZCYseiUGw+omPiAwoQSUANub/mYbAKg2DTQim
         z50TL+P4VS+R+FnFQO+o3nU6RpNqffusSqwZHM/5wX9zyY6t3WpLbME0pbbqhJubtbtB
         OPE7CqkvKWy3qf/F9lbgWok34iAO0gsSriG4PRSKEYxxBuV+jAI63mCyqRljOABcgyf0
         o3lt9nWWo2IHo/jbdPHycxnH+ET03zhpLNZpIrlOm9GRBOoibOlN4ukkDG8KeD4si1s8
         ubGGgEvvKm3gWS9CVrMF6GJ8rDBjfS8P4LTCxH5b4+iJxlkTtOr+kmXxMlAhA2yXUjDg
         sYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OOHUUuKzu4rwfHW3wNAWtip0q7hVj5PZNv1z25ySe5M=;
        fh=cdScJ0VE7ZIqbkwrkxwhj7nO7bfpYMepR8liIS1Uh5I=;
        b=fpJaYPEmHhy1hGcoVwNEd0P4iWX3DEjWCMV4j9kqnkgr5u2nmfYwhU1tIpR6IN4JV+
         2CVSZBD3kfkLYHPjTMpl62+7nDTNo1FC4P30KKStjdISEoURb2HFi3VCYHag+qWswbUM
         w/APRyAuaUQGe8jlzmaB7Yt6pU5lPJpWACmt4xl6tcA5dcG1rXgM5V6acYwbEsWwGRnp
         14oaj2Jdz9SOo2oYTJ2S6xTn2AFpbrpUAoA5DCOlZ5KrmB7NE/zpsL/ua6VkBQLYPoof
         pzFGZKZey6Zgs3VdrFMRjcKHMTbr+848SE5GzwJs4llwS9dhQOFN23Id4m3tk/Osd+us
         FLtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789921662; x=1790526462; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OOHUUuKzu4rwfHW3wNAWtip0q7hVj5PZNv1z25ySe5M=;
        b=CjdqwEVt6/PLNHA+vgYp4tmsMBlc5QRThjhOTbqlM3LXXImJ4MRwQFXGcr7amL378T
         xraBkcCEORXW11C6rGEw14Iefv87G07Mfw2m9rBNEtCBKAOhzz4vEdm7KVkcfEOl+iL3
         XrW+Y7k+cP5nMRXCxSB3F0fQYIGSGzNltiRjjWTzO5SAdh8KrGAsIdotIt0Wv6ae/vw1
         DVgbZzBSEOj+OL7RU8bBAm6Aj+InAo7/mj84ChR2qWV+wdCJigJL9le/Vso2SzlbjFVW
         WacIvG8AqT2jq2ghsOhJBQKO/qknGKNAix2QmiFBLqGMqLaOHRRs8bm6BR7jdG7wkk91
         pyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921662; x=1790526462;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OOHUUuKzu4rwfHW3wNAWtip0q7hVj5PZNv1z25ySe5M=;
        b=j1y5qNfY+wbf9axsvik2JkCOq7GF7tVUqsGF2L1bLetl2WjVLW4ibZDi+0ejML8QVu
         k9oodKpYnXm5/t8pMqKWPu/upqgeO1U0fUv7yjML9bszz5yVrgsVczF9/C2Db18J70+0
         guezNBKyTNo5tK0mVAUVTMljzb5ijihOpoLy+n3Yc6xphoyZMYSGbYsqxiNxZwS6EmS5
         aNuzvwCp2AeP5Wjq6LizU924mQP1gKeb2RqDhgB6MF0Nt5n+cpeS9sc+PWvG6aP0Z+3w
         nb8wyPyRCUHpLm8vO/ocU6PA8umSkoXu6qDvyzjl5RxDKBVoqa1u6Wj78tXReTNpfygE
         p/aA==
X-Forwarded-Encrypted: i=1; AKwUvBxkEmf46in62CbhGyi7Kh8uzmKiwP84P7oaVFmuUkqkCZI9FOPUYky59qE1zZ+4b60BCSu1T8UC3Di5pQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mtBo2UC9mzvWSZM1KpKAM5EmeacXRH5zC5ZFzPSGNSixKgUwYO
	55MRUiqgGLTxG/Waipepw0RMtBV6eRPm8jjqED1td5LKAAv/TvRmSx8ELWq+NmmpPf9fyBPAP6x
	KIvy6UtsPejMSLMhLF3vdkE6IsOMhqpo=
X-Gm-Gg: AYBFou1vJU0AOtuMbMlizn5ONjbBIEv8tCLJCQ6HEmfmx5VCVjloTByxcRPyz0zRa0a
	bFZlVSgDciSB/qIbFP1+OYApv/cdBiz+aVaxRO4JpX5bALGcZgExXHKftcm4eSpKG0Hpkemrmi3
	fGGcmZjSRRvrRxBAAbcO9+otE2QACwX0o3G6/dZlDF88a57v8TykmtkB8aMEVwQD2E7y583aW2C
	bcMu6oBNJfC+FNxyOPX/1WVRZ/LJQJzdKjaxCDIGZinifH/JZ/1ES13pmuaCYE34+mR/HhXJH3S
	1Y9rfOjpcq0hfdl/5DL4Jbpcjvmy8aFIcGSbULveMPhde/y9weZcIFIz4LssHcjRKPrkm6KzHWQ
	J6E3ZIMftuOk=
X-Received: by 2002:a05:600c:138c:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-49fc56ef0cbmr114442195e9.14.1789921661718; Sun, 20 Sep 2026
 09:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Date: Sun, 20 Sep 2026 18:27:28 +0200
X-Gm-Features: AcwNN1WlmptaAsREL24tSf3McPUsp7gZlMM32gCgC6aUV9hvK_r-r9FIlGd3yv0
Message-ID: <CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com>
Subject: zram: block_state returns premature EOF with short read buffers
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

The zram debugfs block_state file returns zero bytes when it is read
with a buffer smaller than one formatted record.

The issue appears to be in read_block_state() in
drivers/block/zram/zram_drv.c:

        copied = snprintf(kbuf + written, count, ...);

        if (count <= copied) {
                slot_unlock(zram, index);
                break;
        }

When the supplied buffer is too small, snprintf() returns the length
that would have been written, rather than the number of bytes copied.
Since copied is then greater than or equal to count, the function breaks
out of the loop without advancing *ppos or increasing written. It
returns zero even though the file contains an allocated block-state
record.

I reproduced this on:

        Linux debian-Utah-1gb 6.12.63+deb13-cloud-amd64
        x86_64

The relevant kernel configuration is:

        CONFIG_ZRAM=m
        CONFIG_ZRAM_MEMORY_TRACKING=y
        CONFIG_DEBUG_FS=y

Reproducer:

        # modprobe zram
        # echo 16M > /sys/block/zram0/disksize
        # dd if=/dev/urandom of=/dev/zram0 bs=4096 count=1 conv=fsync

The slot is allocated:

        # cat /sys/block/zram0/mm_stat
             4096     4096     4096        0        4096        0
  0        1        1

A normal read returns a record:

        # cat /sys/kernel/debug/zram/zram0/block_state
                   0         1161.269400 ..h...

However, reading the same file with a one-byte buffer returns zero
bytes:

        # python3 - <<'PY'
        import os

        path = "/sys/kernel/debug/zram/zram0/block_state"
        fd = os.open(path, os.O_RDONLY)

        try:
            for attempt in range(3):
                data = os.read(fd, 1)
                offset = os.lseek(fd, 0, os.SEEK_CUR)
                print(
                    f"read {attempt}: bytes={len(data)}, "
                    f"data={data!r}, offset={offset}"
                )
        finally:
            os.close(fd)
        PY

        read 0: bytes=0, data=b'', offset=0
        read 1: bytes=0, data=b'', offset=0
        read 2: bytes=0, data=b'', offset=0

The file contains a valid record, but the short-buffer reads return zero
bytes repeatedly and the file position remains unchanged.

This does not appear to be a memory-safety or security issue. The
observed impact is that userspace readers using a short buffer receive
zero bytes and cannot make progress through this debugfs file.

Could you please confirm whether this short-read behavior is expected
for block_state? If it is not expected, should this be fixed directly
in read_block_state(), or should the file be converted to use seq_file?

Thanks for your time and for maintaining zram.

Pooyan Azad
