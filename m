Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F533065C
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124595; cv=none; b=Gv+zSt1z5yn8OoKaXR8xCymFmIASqbDlaOoetKFJ+0+t6I9IqLl1je3bts92wgE6OZzRLBDlOxt2+59ERykA2J9nVq1CzE838DKD46MQd651rM8G7+oFXKBIE6qadxmar7Q+1PZXRnWGIbtlp+yObhYvqThZL7DxuIt46h7MBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124595; c=relaxed/simple;
	bh=xXgFYRZxIxf/2kFo1l7bdVqmhQDloiRBC7h/oaSV7yU=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=IRQtpiywgzroghm4WrgOfevfCBdYT+sXLDfGwaS/nsfpUjwOzj2RNngQoJ5NJJqpsM2XMXhLRaHq3+Qv8FQ7kWG3EfKrBZOwoNd/WvE0eo1fFWPIRYaJmSVqMkO92dk/yXSMa20+xdjSJn7HCicnW+zywL/RndnyAO7271eLYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJc9ZaMN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJc9ZaMN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a09d981507so32855425ad.1
        for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768124592; x=1768729392; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HbGwYynWGCQ/Lk5rY1Q7r5SrpE6Goj1HNqcNsFw5hz4=;
        b=MJc9ZaMNNTLquuAYM77dVl4IbLgAxQqmS3W87jmtgJlId5weEAW1avyqBnOS3u9LKP
         UGKhdEvpXzSJ3PnW0EP8K63/CaEGyPhsEqFzBEYeQ4/LqWl8nGS+MU5oYpSr9qpdnv9w
         zBMBGh0944pik7sy6fTj6EJ36FORfwR+eZKbo3OxDeBZ1q/2SR9IXseUOqX1rPlpth7R
         BYN1Spxjx3rKGBdsJqHw8vEeiamwh3PAgeornOUpTl/Uwlqy3wmtg3XFt3k+6CkFhnZp
         zCVThufuhwdKHQOgIhxPz0MYMUrieZQJPNGelN2PDUHqD+Bv9ahin5ntmJijN6jevZGy
         u4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768124592; x=1768729392;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbGwYynWGCQ/Lk5rY1Q7r5SrpE6Goj1HNqcNsFw5hz4=;
        b=Vc4K+8WuvtkWUOue/gxM4IbQ8m15iocuOcpDgE2rsyiGpwW3HfTEP+wyGcaG9ps6hA
         3kGlp8sRvlyQM6NBxoG4aKMZue4aVAOvAza1IUJzzk4XmEOY0k29iJVbBtp9HiDaw4SM
         KZkLXmaOsAH8ekWzfCPNok1A+S7Ognlm6r8oLM++2805pcb7fq9RGW97+pzoyLIr7Xtg
         iyZx3l9EPTAEOMB7k/SiJElHHR9c96QZtUlEXpBHma86X1WhZDgjTTnk+CX/r4NJFvxU
         W63Z9tj4WkETSdgyZ4CH11UWOl86yiK/0/9ramssOSZPszOlZAHoml1MR66IcIWywmrt
         YeIw==
X-Gm-Message-State: AOJu0YyKmCiGvaxe9qB92zNTutAYOnVzKd8XR5tkWz4BphNlG9yQP/Js
	XGFr5u6XCmvlN1ECXtk3ZGE/4luMWoy8SQwdGpSPFIXUtNcX5efOzJYQ
X-Gm-Gg: AY/fxX6YveWf3Yi/+qutJeOnfhQ1P0cbKZlmqgYZ7BGsJABNdCxxtTYEwdvIBR8k1ON
	Lg8XKEbLzG9GVaLDD5BPR6XY2giAtROezzWcKPruUC32KV1nU25jz6GGUE1YpE1lCOvMF7lmAhp
	ZWFXTvI91CIYYG7Tgr/29q1OEli74CW9JT2kDNbm4hn2esLIygYcTdxOOin8o2We340n+URUKY0
	tOhrJ1ihZHwxkhZGIQBaUGI4Bwx6jnHIMoStwXPUf5zvrn02vwTASJja9oELh1jB5hDJnlEdK2p
	CtMG0XFr9TPaYpWhd+Viu8kns7ip5Ad5UnXCvoGaTSydF0Q7cpKf+nuqOZDYNIIC6jAh3xaQQB7
	YnVSffoy6Ja64KIJdLqI5JgZ2mjJ6Hz4/N0t+0cXlmudrXzYaXwgkf9jmIKwEscjExUatXIHeNQ
	o7ow//d5ZtiFosyJ6iBHP9WHSfez1DhjgJxzp9kts5+3UUE6HlxsjCs0k=
X-Google-Smtp-Source: AGHT+IEQ0mcysciVj1qZSr4bE0+3pck9+ewm59UIEnddfPAGm6ZoBsj800PDPYu6Xq9Q3W/I4tRVDw==
X-Received: by 2002:a17:902:f544:b0:2a0:835f:3d5b with SMTP id d9443c01a7336-2a3e3982488mr174688925ad.6.1768124591238;
        Sun, 11 Jan 2026 01:43:11 -0800 (PST)
Received: from DESKTOP-85LD9SI. (118-167-232-86.dynamic-ip.hinet.net. [118.167.232.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm144613965ad.0.2026.01.11.01.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 01:43:10 -0800 (PST)
Message-ID: <696370ae.170a0220.397add.82b5@mx.google.com>
X-Google-Original-Message-ID: <aWNwrMAGZGy7dF9l@DESKTOP-85LD9SI.>
Date: Sun, 11 Jan 2026 17:43:08 +0800
From: JiaHong Su <s11242586@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] blk-mq: hung task in blk_mq_get_tag()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I found the following issue using Syzkaller on:

HEAD commit:    9ace475 Linux 6.19-rc4

Multiple tasks are blocked in blk_mq_get_tag(), causing system-wide I/O stall.
The hung task warnings show 10+ tasks stuck waiting at blk_mq_get_tag+0x566/0xae0.

C reproducer:

// autogenerated by syzkaller

#define _GNU_SOURCE 

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
	usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
	struct timespec ts;
	if (clock_gettime(CLOCK_MONOTONIC, &ts))
	exit(1);
	return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
	char buf[1024];
	va_list args;
	va_start(args, what);
	vsnprintf(buf, sizeof(buf), what, args);
	va_end(args);
	buf[sizeof(buf) - 1] = 0;
	int len = strlen(buf);
	int fd = open(file, O_WRONLY | O_CLOEXEC);
	if (fd == -1)
		return false;
	if (write(fd, buf, len) != len) {
		int err = errno;
		close(fd);
		errno = err;
		return false;
	}
	close(fd);
	return true;
}

static void kill_and_wait(int pid, int* status)
{
	kill(-pid, SIGKILL);
	kill(pid, SIGKILL);
	for (int i = 0; i < 100; i++) {
		if (waitpid(-1, status, WNOHANG | __WALL) == pid)
			return;
		usleep(1000);
	}
	DIR* dir = opendir("/sys/fs/fuse/connections");
	if (dir) {
		for (;;) {
			struct dirent* ent = readdir(dir);
			if (!ent)
				break;
			if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
				continue;
			char abort[300];
			snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort", ent->d_name);
			int fd = open(abort, O_WRONLY);
			if (fd == -1) {
				continue;
			}
			if (write(fd, abort, 1) < 0) {
			}
			close(fd);
		}
		closedir(dir);
	} else {
	}
	while (waitpid(-1, status, __WALL) != pid) {
	}
}

static void setup_test()
{
	prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
	setpgrp();
	write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
	int iter = 0;
	for (;; iter++) {
		int pid = fork();
		if (pid < 0)
	exit(1);
		if (pid == 0) {
			setup_test();
			execute_one();
			exit(0);
		}
		int status = 0;
		uint64_t start = current_time_ms();
		for (;;) {
			sleep_ms(10);
			if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
				break;
			if (current_time_ms() - start < 5000)
				continue;
			kill_and_wait(pid, &status);
			break;
		}
	}
}

uint64_t r[3] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};

void execute_one(void)
{
		intptr_t res = 0;
	if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
//  openat$kvm arguments: [
//    fd: const = 0x0 (8 bytes)
//    file: ptr[in, buffer] {
//      buffer: {2f 64 65 76 2f 6b 76 6d 00} (length 0x9)
//    }
//    flags: open_flags = 0x0 (4 bytes)
//    mode: const = 0x0 (2 bytes)
//  ]
//  returns fd_kvm
memcpy((void*)0x200000000000, "/dev/kvm\000", 9);
	syscall(__NR_openat, /*fd=*/0ul, /*file=*/0x200000000000ul, /*flags=*/0, /*mode=*/0);
//  ioctl$KVM_GET_MSRS_cpu arguments: [
//    fd: fd_kvmcpu (resource)
//    cmd: const = 0xc008ae88 (4 bytes)
//    arg: ptr[inout, kvm_msrs] {
//      kvm_msrs {
//        nmsrs: len = 0x1 (4 bytes)
//        pad: const = 0x0 (4 bytes)
//        entries: array[kvm_msr_entry] {
//          kvm_msr_entry {
//            index: msr_index = 0x40000003 (4 bytes)
//            reserv: const = 0x0 (4 bytes)
//            data: int64 = 0xaf9 (8 bytes)
//          }
//        }
//      }
//    }
//  ]
*(uint32_t*)0x200000000180 = 1;
*(uint32_t*)0x200000000184 = 0;
*(uint32_t*)0x200000000188 = 0x40000003;
*(uint32_t*)0x20000000018c = 0;
*(uint64_t*)0x200000000190 = 0xaf9;
	syscall(__NR_ioctl, /*fd=*/(intptr_t)-1, /*cmd=*/0xc008ae88, /*arg=*/0x200000000180ul);
//  openat$bsg arguments: [
//    fd: const = 0xffffffffffffff9c (8 bytes)
//    file: ptr[in, buffer] {
//      buffer: {2f 64 65 76 2f 62 73 67 2f 30 3a 30 3a 30 3a 30 00} (length 0x11)
//    }
//    flags: open_flags = 0x0 (4 bytes)
//    mode: const = 0x0 (2 bytes)
//  ]
//  returns fd_bsg
memcpy((void*)0x200000000080, "/dev/bsg/0:0:0:0\000", 17);
	res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x200000000080ul, /*flags=*/0, /*mode=*/0);
	if (res != -1)
		r[0] = res;
//  openat$sysfs arguments: [
//    fd: const = 0xffffffffffffff9c (8 bytes)
//    dir: ptr[in, buffer] {
//      buffer: {2f 73 79 73 2f 70 6f 77 65 72 2f 73 79 6e 63 5f 6f 6e 5f 73 75 73 70 65 6e 64} (length 0x1a)
//    }
//    flags: open_flags = 0x482 (4 bytes)
//    mode: open_mode = 0x0 (2 bytes)
//  ]
//  returns fd
memcpy((void*)0x200000000000, "/sys/power/sync_on_suspend", 26);
	res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*dir=*/0x200000000000ul, /*flags=O_EXCL|O_APPEND|O_RDWR*/0x482, /*mode=*/0);
	if (res != -1)
		r[1] = res;
//  openat$sr arguments: [
//    fd: const = 0xffffffffffffff9c (8 bytes)
//    file: ptr[in, buffer] {
//      buffer: {2f 64 65 76 2f 73 72 30 00} (length 0x9)
//    }
//    flags: open_flags = 0x881 (4 bytes)
//    mode: const = 0x0 (2 bytes)
//  ]
//  returns fd
memcpy((void*)0x200000000000, "/dev/sr0\000", 9);
	res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x200000000000ul, /*flags=O_NONBLOCK|O_EXCL|O_WRONLY*/0x881, /*mode=*/0);
	if (res != -1)
		r[2] = res;
//  ioctl$CDROM_SELECT_DISK arguments: [
//    fd: fd_cdrom (resource)
//    cmd: const = 0x5322 (4 bytes)
//    disk: intptr = 0x5048 (8 bytes)
//  ]
	syscall(__NR_ioctl, /*fd=*/r[2], /*cmd=*/0x5322, /*disk=*/0x5048ul);
//  ioctl$KVM_PRE_FAULT_MEMORY arguments: [
//    fd: fd_kvmcpu (resource)
//    cmd: const = 0xc040aed5 (4 bytes)
//    arg: ptr[inout, kvm_pre_fault_memory] {
//      kvm_pre_fault_memory {
//        gpa: kvm_guest_addrs = 0x3000 (8 bytes)
//        size: kvm_guest_addr_size = 0x12000 (8 bytes)
//        flags: const = 0x0 (8 bytes)
//        pad: buffer: {00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00} (length 0x28)
//      }
//    }
//  ]
*(uint64_t*)0x200000000040 = 0x3000;
*(uint64_t*)0x200000000048 = 0x12000;
*(uint64_t*)0x200000000050 = 0;
memset((void*)0x200000000058, 0, 40);
	syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0xc040aed5, /*arg=*/0x200000000040ul);
//  ioctl$BSG_IO arguments: [
//    fd: fd_bsg (resource)
//    cmd: const = 0x2285 (4 bytes)
//    arg: ptr[inout, sg_io_v4] {
//      sg_io_v4 {
//        guard: bsg_guard = 0x51 (4 bytes)
//        prot: const = 0x0 (4 bytes)
//        subprot: bsg_sub_protocols = 0x0 (4 bytes)
//        req_len: len = 0xa (4 bytes)
//        req: ptr[in, buffer] {
//          buffer: {a1 07 00 2d e2 7e 35 2e 56 c5} (length 0xa)
//        }
//        req_tag: int64 = 0xf (8 bytes)
//        req_attr: const = 0x0 (4 bytes)
//        req_prio: int32 = 0x8 (4 bytes)
//        req_extra: int32 = 0xbca (4 bytes)
//        max_resp_len: bytesize = 0x0 (4 bytes)
//        resp: nil
//        dout_iovec_count: const = 0x0 (4 bytes)
//        dout_xfer_len: len = 0x0 (4 bytes)
//        din_iovec_count: const = 0x0 (4 bytes)
//        din_xfer_len: len = 0x0 (4 bytes)
//        dout_xferp: nil
//        din_xferp: nil
//        timeout: int32 = 0xb0f9 (4 bytes)
//        flags: bsg_flags = 0x30 (4 bytes)
//        usr_ptr: nil
//        spare_in: int32 = 0xfb3b (4 bytes)
//        drv_status: const = 0x0 (4 bytes)
//        trans_status: const = 0x0 (4 bytes)
//        dev_status: const = 0x0 (4 bytes)
//        retry_delay: const = 0x0 (4 bytes)
//        info: const = 0x0 (4 bytes)
//        dur: const = 0x0 (4 bytes)
//        resp_len: const = 0x0 (4 bytes)
//        din_resid: const = 0x0 (4 bytes)
//        dout_resid: const = 0x0 (4 bytes)
//        gen_tag: const = 0x0 (8 bytes)
//        spare_out: const = 0x0 (4 bytes)
//        pad: const = 0x0 (4 bytes)
//      }
//    }
//  ]
*(uint32_t*)0x200000000480 = 0x51;
*(uint32_t*)0x200000000484 = 0;
*(uint32_t*)0x200000000488 = 0;
*(uint32_t*)0x20000000048c = 0xa;
*(uint64_t*)0x200000000490 = 0x200000000100;
memcpy((void*)0x200000000100, "\xa1\x07\x00\x2d\xe2\x7e\x35\x2e\x56\xc5", 10);
*(uint64_t*)0x200000000498 = 0xf;
*(uint32_t*)0x2000000004a0 = 0;
*(uint32_t*)0x2000000004a4 = 8;
*(uint32_t*)0x2000000004a8 = 0xbca;
*(uint32_t*)0x2000000004ac = 0;
*(uint64_t*)0x2000000004b0 = 0;
*(uint32_t*)0x2000000004b8 = 0;
*(uint32_t*)0x2000000004bc = 0;
*(uint32_t*)0x2000000004c0 = 0;
*(uint32_t*)0x2000000004c4 = 0;
*(uint64_t*)0x2000000004c8 = 0;
*(uint64_t*)0x2000000004d0 = 0;
*(uint32_t*)0x2000000004d8 = 0xb0f9;
*(uint32_t*)0x2000000004dc = 0x30;
*(uint64_t*)0x2000000004e0 = 0;
*(uint32_t*)0x2000000004e8 = 0xfb3b;
*(uint32_t*)0x2000000004ec = 0;
*(uint32_t*)0x2000000004f0 = 0;
*(uint32_t*)0x2000000004f4 = 0;
*(uint32_t*)0x2000000004f8 = 0;
*(uint32_t*)0x2000000004fc = 0;
*(uint32_t*)0x200000000500 = 0;
*(uint32_t*)0x200000000504 = 0;
*(uint32_t*)0x200000000508 = 0;
*(uint32_t*)0x20000000050c = 0;
*(uint64_t*)0x200000000510 = 0;
*(uint32_t*)0x200000000518 = 0;
*(uint32_t*)0x20000000051c = 0;
	syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x2285, /*arg=*/0x200000000480ul);
//  ioctl$BINDER_GET_FROZEN_INFO arguments: [
//    fd: fd_binder (resource)
//    cmd: const = 0xc00c620f (4 bytes)
//    arg: nil
//  ]
	syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0xc00c620f, /*arg=*/0ul);
//  ioctl$BINDER_GET_FROZEN_INFO arguments: [
//    fd: fd_binder (resource)
//    cmd: const = 0xc00c620f (4 bytes)
//    arg: nil
//  ]
	syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0xc00c620f, /*arg=*/0ul);

}
int main(void)
{
		syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul, /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	const char* reason;
	(void)reason;
	for (procid = 0; procid < 8; procid++) {
		if (fork() == 0) {
			loop();
		}
	}
	sleep(1000000);
	return 0;
}

---

Full dmesg output:

INFO: task kworker/1:1:52 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:26072 pid:52    tgid:52    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events ata_scsi_dev_rescan
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 blk_mq_get_tag+0x566/0xae0
 ? __pfx_blk_mq_get_tag+0x10/0x10
 ? __pfx_autoremove_wake_function+0x10/0x10
 __blk_mq_alloc_requests+0xaf6/0x1640
 ? __pfx___blk_mq_alloc_requests+0x10/0x10
 ? ret_from_fork_asm+0x1a/0x30
 ? ret_from_fork_asm+0x1a/0x30
 ? kernel_text_address+0x11/0x90
 ? __pfx_stack_trace_consume_entry+0x10/0x10
 blk_mq_alloc_request+0x791/0x990
 ? __kasan_check_byte+0x14/0x50
 ? __pfx_blk_mq_alloc_request+0x10/0x10
 ? unwind_next_frame+0x3b1/0x20c0
 ? unwind_next_frame+0x3b1/0x20c0
 ? rcu_is_watching+0x12/0xc0
 scsi_execute_cmd+0x1f9/0xe10
 ? __lock_acquire+0x490/0x2610
 ? __pfx_scsi_execute_cmd+0x10/0x10
 scsi_vpd_inquiry+0xd0/0x210
 ? __pfx_scsi_vpd_inquiry+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? trace_contention_end+0xdc/0x110
 scsi_get_vpd_size+0xfb/0x2c0
 ? __pfx_scsi_get_vpd_size+0x10/0x10
 ? __pfx___mutex_lock+0x10/0x10
 scsi_get_vpd_buf+0x28/0x170
 scsi_attach_vpd+0x10f/0x390
 scsi_rescan_device+0xfa/0x340
 ata_scsi_dev_rescan+0x1b7/0x430
 process_one_work+0x992/0x1b00
 ? __pfx_process_one_work+0x10/0x10
 ? assign_work+0x196/0x240
 worker_thread+0x67e/0xe90
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x3d0/0x780
 ? __pfx_kthread+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x966/0xaf0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x76c/0x10d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
INFO: task kworker/u9:12:2982 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:12   state:D stack:23272 pid:2982  tgid:2982  ppid:2      task_flags:0x4248060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __pfx_blk_mq_flush_plug_list+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 ? __blk_flush_plug+0x309/0x4c0
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 blk_mq_get_tag+0x566/0xae0
 ? __pfx_blk_mq_get_tag+0x10/0x10
 ? _raw_spin_unlock_irqrestore+0x41/0x70
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __pfx_rq_qos_wait+0x10/0x10
 ? __pfx___mod_timer+0x10/0x10
 ? __pfx_dd_limit_depth+0x10/0x10
 __blk_mq_alloc_requests+0xaf6/0x1640
 ? __pfx___blk_mq_alloc_requests+0x10/0x10
 ? __pfx_dd_bio_merge+0x10/0x10
 ? __pfx_wbt_wait+0x10/0x10
 blk_mq_submit_bio+0x1305/0x2ad0
 ? __pfx_blk_mq_submit_bio+0x10/0x10
 ? folios_put_refs+0x520/0x750
 ? __pfx_folios_put_refs+0x10/0x10
 __submit_bio+0x3be/0x670
 ? __pfx___submit_bio+0x10/0x10
 ? blk_cgroup_bio_start+0x306/0x690
 ? __pfx_blk_cgroup_bio_start+0x10/0x10
 ? submit_bio_noacct_nocheck+0x540/0xbb0
 submit_bio_noacct_nocheck+0x540/0xbb0
 ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
 submit_bio_noacct+0xca7/0x1f50
 ext4_io_submit+0xa6/0x140
 ext4_do_writepages+0x99f/0x39a0
 ? _raw_spin_unlock_irqrestore+0x58/0x70
 ? __lock_acquire+0x490/0x2610
 ? __pfx_ext4_do_writepages+0x10/0x10
 ? ext4_writepages+0x37a/0x7c0
 ext4_writepages+0x37a/0x7c0
 ? __pfx_ext4_writepages+0x10/0x10
 ? do_writepages+0x462/0x5b0
 ? __pfx_ext4_writepages+0x10/0x10
 do_writepages+0x242/0x5b0
 __writeback_single_inode+0x127/0x13d0
 ? wbc_attach_and_unlock_inode.part.0+0x45f/0x870
 writeback_sb_inodes+0x6c0/0x1aa0
 ? __pfx_writeback_sb_inodes+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 __writeback_inodes_wb+0xbe/0x270
 wb_writeback+0x6dd/0xae0
 ? __pfx_wb_writeback+0x10/0x10
 ? get_nr_dirty_inodes+0x60/0x1d0
 wb_workfn+0x700/0xb80
 ? debug_object_deactivate+0x213/0x390
 ? __pfx_wb_workfn+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 process_one_work+0x992/0x1b00
 ? __pfx_process_one_work+0x10/0x10
 ? assign_work+0x196/0x240
 worker_thread+0x67e/0xe90
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x3d0/0x780
 ? __pfx_kthread+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x966/0xaf0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x76c/0x10d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
INFO: task jbd2/sda-8:5196 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda-8      state:D stack:25912 pid:5196  tgid:5196  ppid:2      task_flags:0x240040 flags:0x00080000
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __pfx_blk_mq_flush_plug_list+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 ? __blk_flush_plug+0x309/0x4c0
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 blk_mq_get_tag+0x566/0xae0
 ? __pfx_blk_mq_get_tag+0x10/0x10
 ? dd_request_merge+0x188/0x3e0
 ? __pfx_dd_request_merge+0x10/0x10
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __sanitizer_cov_trace_switch+0x54/0x90
 ? __pfx_dd_limit_depth+0x10/0x10
 __blk_mq_alloc_requests+0xaf6/0x1640
 ? __sanitizer_cov_trace_switch+0x54/0x90
 ? __pfx___blk_mq_alloc_requests+0x10/0x10
 ? __pfx_dd_bio_merge+0x10/0x10
 ? __pfx_wbt_wait+0x10/0x10
 blk_mq_submit_bio+0x1305/0x2ad0
 ? __lock_acquire+0x490/0x2610
 ? __pfx_blk_mq_submit_bio+0x10/0x10
 __submit_bio+0x3be/0x670
 ? __pfx___submit_bio+0x10/0x10
 ? bio_associate_blkg_from_css+0x537/0x1360
 ? blk_cgroup_bio_start+0x306/0x690
 ? __pfx_blk_cgroup_bio_start+0x10/0x10
 ? submit_bio_noacct_nocheck+0x540/0xbb0
 submit_bio_noacct_nocheck+0x540/0xbb0
 ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
 submit_bio_noacct+0xca7/0x1f50
 jbd2_journal_commit_transaction+0x1eda/0x6820
 ? __pfx_jbd2_journal_commit_transaction+0x10/0x10
 ? do_raw_spin_lock+0x12b/0x2b0
 ? find_held_lock+0x2b/0x80
 ? _raw_spin_unlock_irqrestore+0x41/0x70
 ? __try_to_del_timer_sync+0x107/0x160
 ? __timer_delete_sync+0x18d/0x1c0
 kjournald2+0x1d8/0x720
 ? __pfx_kjournald2+0x10/0x10
 ? _raw_spin_unlock_irqrestore+0x58/0x70
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __kthread_parkme+0x1b1/0x250
 ? __pfx_kjournald2+0x10/0x10
 kthread+0x3d0/0x780
 ? __pfx_kthread+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x966/0xaf0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x76c/0x10d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
INFO: task systemd-journal:5222 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-journal state:D stack:23048 pid:5222  tgid:5222  ppid:1      task_flags:0x440100 flags:0x00080002
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __lock_acquire+0x490/0x2610
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 bit_wait_io+0x15/0xf0
 __wait_on_bit+0x6a/0x1b0
 ? __pfx_bit_wait_io+0x10/0x10
 out_of_line_wait_on_bit+0xda/0x110
 ? __pfx_out_of_line_wait_on_bit+0x10/0x10
 ? __pfx_wake_bit_function+0x10/0x10
 ? do_raw_spin_unlock+0x174/0x230
 do_get_write_access+0x83b/0x1070
 jbd2_journal_get_write_access+0x1d5/0x260
 __ext4_journal_get_write_access+0x6a/0x340
 ext4_reserve_inode_write+0x217/0x350
 __ext4_mark_inode_dirty+0x17e/0x810
 ? __pfx___ext4_mark_inode_dirty+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? trace_jbd2_handle_start+0x1aa/0x200
 ? jbd2__journal_start+0xf7/0x6b0
 ? __ext4_journal_start_sb+0x194/0x630
 ? __ext4_journal_start_sb+0x19d/0x630
 ? ext4_dirty_inode+0xa5/0x130
 ? __pfx_ext4_dirty_inode+0x10/0x10
 ext4_dirty_inode+0xdd/0x130
 ? rcu_is_watching+0x12/0xc0
 __mark_inode_dirty+0x1f7/0x1510
 generic_update_time+0xcb/0xf0
 file_update_time_flags+0x407/0x500
 ext4_page_mkwrite+0x33d/0x1800
 ? lockdep_hardirqs_on+0x7c/0x110
 ? __pfx_ext4_page_mkwrite+0x10/0x10
 do_page_mkwrite+0x17a/0x390
 do_wp_page+0x1233/0x4eb0
 ? __pfx_do_wp_page+0x10/0x10
 ? do_raw_spin_lock+0x12b/0x2b0
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? ___pte_offset_map+0x171/0x380
 __handle_mm_fault+0x1b30/0x2ac0
 ? reacquire_held_locks+0xd1/0x1f0
 ? __pfx___handle_mm_fault+0x10/0x10
 ? lock_vma_under_rcu+0x177/0x590
 ? __pfx_lock_vma_under_rcu+0x10/0x10
 ? __pfx___do_sys_newfstat+0x10/0x10
 handle_mm_fault+0x3f9/0xac0
 do_user_addr_fault+0x61b/0x1310
 ? rcu_is_watching+0x12/0xc0
 exc_page_fault+0xbe/0x170
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x7f2b1e9c60be
RSP: 002b:00007fff4cd9a170 EFLAGS: 00010246
RAX: 00007f2b1c820890 RBX: 000055cc3119f800 RCX: 0000000000005687
RDX: 0000000000000000 RSI: 000055cc3119f800 RDI: 00007f2b1c9da6c0
RBP: 000055cc311cb9a0 R08: 00000000001da680 R09: 00000000001da680
R10: 0000000000000002 R11: 0000000000009216 R12: 0000000000000025
R13: 000000000001f2a0 R14: 0000000000000000 R15: 00007fff4cd9a190
 </TASK>
INFO: task kworker/u9:31:8341 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:31   state:D stack:24104 pid:8341  tgid:8341  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __pfx_blk_mq_flush_plug_list+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 ? __blk_flush_plug+0x309/0x4c0
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 blk_mq_get_tag+0x566/0xae0
 ? __pfx_blk_mq_get_tag+0x10/0x10
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __pfx_rq_qos_wait+0x10/0x10
 ? __pfx_dd_limit_depth+0x10/0x10
 __blk_mq_alloc_requests+0xaf6/0x1640
 ? __pfx___blk_mq_alloc_requests+0x10/0x10
 ? __pfx_dd_bio_merge+0x10/0x10
 ? __pfx_wbt_wait+0x10/0x10
 blk_mq_submit_bio+0x1305/0x2ad0
 ? __pfx_blk_mq_submit_bio+0x10/0x10
 __submit_bio+0x3be/0x670
 ? __pfx___submit_bio+0x10/0x10
 ? blk_cgroup_bio_start+0x306/0x690
 ? __pfx_blk_cgroup_bio_start+0x10/0x10
 ? submit_bio_noacct_nocheck+0x540/0xbb0
 submit_bio_noacct_nocheck+0x540/0xbb0
 ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
 submit_bio_noacct+0xca7/0x1f50
 __block_write_full_folio+0x727/0xde0
 ? __pfx_blkdev_get_block+0x10/0x10
 ? __pfx_blkdev_get_block+0x10/0x10
 block_write_full_folio+0x34d/0x410
 blkdev_writepages+0x9f/0x120
 ? __pfx_blkdev_writepages+0x10/0x10
 ? find_held_lock+0x2b/0x80
 ? do_writepages+0x462/0x5b0
 ? do_raw_spin_unlock+0x174/0x230
 ? __pfx_blkdev_writepages+0x10/0x10
 do_writepages+0x242/0x5b0
 __writeback_single_inode+0x127/0x13d0
 ? wbc_attach_and_unlock_inode.part.0+0x45f/0x870
 writeback_sb_inodes+0x6c0/0x1aa0
 ? __pfx_writeback_sb_inodes+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 __writeback_inodes_wb+0xbe/0x270
 wb_writeback+0x6dd/0xae0
 ? __pfx_wb_writeback+0x10/0x10
 ? get_nr_dirty_inodes+0x60/0x1d0
 wb_workfn+0x700/0xb80
 ? debug_object_deactivate+0x213/0x390
 ? __pfx_wb_workfn+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 process_one_work+0x992/0x1b00
 ? __pfx_process_one_work+0x10/0x10
 ? assign_work+0x196/0x240
 worker_thread+0x67e/0xe90
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x3d0/0x780
 ? __pfx_kthread+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x966/0xaf0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x76c/0x10d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
INFO: task kworker/u9:33:8733 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:33   state:D stack:25160 pid:8733  tgid:8733  ppid:2      task_flags:0x4248060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __pfx_blk_mq_flush_plug_list+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 ? __blk_flush_plug+0x309/0x4c0
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 rq_qos_wait+0x21e/0x320
 ? __pfx_wbt_cleanup_cb+0x10/0x10
 ? __pfx_rq_qos_wait+0x10/0x10
 ? __pfx_rq_qos_wake_function+0x10/0x10
 ? __pfx_wbt_inflight_cb+0x10/0x10
 ? do_raw_spin_unlock+0x174/0x230
 wbt_wait+0x1c8/0x3b0
 ? __pfx_wbt_wait+0x10/0x10
 ? __pfx_dd_bio_merge+0x10/0x10
 ? __pfx_wbt_wait+0x10/0x10
 __rq_qos_throttle+0x56/0xa0
 blk_mq_submit_bio+0x243f/0x2ad0
 ? __pfx_blk_mq_submit_bio+0x10/0x10
 ? __pfx_page_vma_mkclean_one.constprop.0+0x10/0x10
 __submit_bio+0x3be/0x670
 ? __pfx_css_rstat_updated+0x10/0x10
 ? __pfx___submit_bio+0x10/0x10
 ? blk_cgroup_bio_start+0x306/0x690
 ? __pfx_blk_cgroup_bio_start+0x10/0x10
 ? mod_memcg_lruvec_state+0x395/0x620
 ? submit_bio_noacct_nocheck+0x540/0xbb0
 submit_bio_noacct_nocheck+0x540/0xbb0
 ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
 submit_bio_noacct+0xca7/0x1f50
 ext4_bio_write_folio+0x95a/0x1d10
 mpage_process_page_bufs+0x6aa/0x830
 mpage_prepare_extent_to_map+0x73e/0x1450
 ? __pfx_mpage_prepare_extent_to_map+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? trace_kmem_cache_alloc+0x28/0xb0
 ? kmem_cache_alloc_noprof+0x2b7/0x790
 ? submit_bio_noacct+0xca7/0x1f50
 ? ext4_init_io_end+0x27/0x180
 ext4_do_writepages+0x983/0x39a0
 ? stack_depot_print+0x50/0x50
 ? ret_from_fork_asm+0x1a/0x30
 ? __lock_acquire+0x490/0x2610
 ? __pfx_ext4_do_writepages+0x10/0x10
 ? ext4_writepages+0x37a/0x7c0
 ext4_writepages+0x37a/0x7c0
 ? __pfx_ext4_writepages+0x10/0x10
 ? do_writepages+0x462/0x5b0
 ? __pfx_ext4_writepages+0x10/0x10
 do_writepages+0x242/0x5b0
 __writeback_single_inode+0x127/0x13d0
 ? wbc_attach_and_unlock_inode.part.0+0x45f/0x870
 writeback_sb_inodes+0x6c0/0x1aa0
 ? __pfx_writeback_sb_inodes+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 __writeback_inodes_wb+0xbe/0x270
 wb_writeback+0x6dd/0xae0
 ? __pfx_wb_writeback+0x10/0x10
 ? get_nr_dirty_inodes+0x60/0x1d0
 wb_workfn+0x700/0xb80
 ? debug_object_deactivate+0x213/0x390
 ? __pfx_wb_workfn+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 process_one_work+0x992/0x1b00
 ? __pfx_process_one_work+0x10/0x10
 ? assign_work+0x196/0x240
 worker_thread+0x67e/0xe90
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x3d0/0x780
 ? __pfx_kthread+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x966/0xaf0
 ? __pfx_ret_from_fork+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? __switch_to+0x76c/0x10d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
INFO: task rs:main Q:Reg:9088 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rs:main Q:Reg   state:D stack:26088 pid:9088  tgid:9044  ppid:1      task_flags:0x440140 flags:0x00080000
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __lock_acquire+0x490/0x2610
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 bit_wait_io+0x15/0xf0
 __wait_on_bit+0x6a/0x1b0
 ? __pfx_bit_wait_io+0x10/0x10
 out_of_line_wait_on_bit+0xda/0x110
 ? __pfx_out_of_line_wait_on_bit+0x10/0x10
 ? __pfx_wake_bit_function+0x10/0x10
 ? do_raw_spin_unlock+0x174/0x230
 do_get_write_access+0x83b/0x1070
 jbd2_journal_get_write_access+0x1d5/0x260
 __ext4_journal_get_write_access+0x6a/0x340
 ext4_reserve_inode_write+0x217/0x350
 __ext4_mark_inode_dirty+0x17e/0x810
 ? kmem_cache_alloc_noprof+0x2b7/0x790
 ? __pfx___ext4_mark_inode_dirty+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? trace_jbd2_handle_start+0x1aa/0x200
 ? jbd2__journal_start+0xf7/0x6b0
 ? __ext4_journal_start_sb+0x194/0x630
 ? __ext4_journal_start_sb+0x19d/0x630
 ? ext4_dirty_inode+0xa5/0x130
 ? __pfx_ext4_dirty_inode+0x10/0x10
 ext4_dirty_inode+0xdd/0x130
 ? rcu_is_watching+0x12/0xc0
 __mark_inode_dirty+0x1f7/0x1510
 generic_update_time+0xcb/0xf0
 file_update_time_flags+0x407/0x500
 file_modified+0x39/0x50
 ext4_buffered_write_iter+0xf4/0x430
 ext4_file_write_iter+0xa51/0x1c70
 ? __pfx_ext4_file_write_iter+0x10/0x10
 vfs_write+0xc0d/0x1170
 ? __pfx_ext4_file_write_iter+0x10/0x10
 ? __pfx_vfs_write+0x10/0x10
 ksys_write+0x121/0x240
 ? __pfx_ksys_write+0x10/0x10
 do_syscall_64+0xcb/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f252d62afef
RSP: 002b:00007f2527ffe860 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2518001530 RCX: 00007f252d62afef
RDX: 000000000000005c RSI: 00007f25180017f0 RDI: 0000000000000007
RBP: 000000000000005c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f25180017f0
R13: 0000000000000000 R14: 000000000000005c R15: 00007f2518001530
 </TASK>
INFO: task repro:9782 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:repro           state:D stack:26936 pid:9782  tgid:9782  ppid:9780   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __lock_acquire+0x490/0x2610
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 blk_mq_get_tag+0x566/0xae0
 ? __pfx_blk_mq_get_tag+0x10/0x10
 ? __pfx_autoremove_wake_function+0x10/0x10
 __blk_mq_alloc_requests+0xaf6/0x1640
 ? __pfx___blk_mq_alloc_requests+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 blk_mq_alloc_request+0x791/0x990
 ? __pfx_blk_mq_alloc_request+0x10/0x10
 ? __might_fault+0x138/0x190
 scsi_alloc_request+0x23/0x60
 scsi_bsg_sg_io_fn+0x155/0xb50
 ? __pfx_scsi_bsg_sg_io_fn+0x10/0x10
 bsg_sg_io+0x1a3/0x2a0
 ? __pfx_bsg_sg_io+0x10/0x10
 ? __pfx_sr_block_ioctl+0x10/0x10
 ? blkdev_ioctl+0x188/0x6c0
 bsg_ioctl+0x578/0x5e0
 ? __pfx_bsg_ioctl+0x10/0x10
 __x64_sys_ioctl+0x18f/0x210
 do_syscall_64+0xcb/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x451d2d
RSP: 002b:00007ffd6020d408 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400518 RCX: 0000000000451d2d
RDX: 0000200000000480 RSI: 0000000000002285 RDI: 0000000000000004
RBP: 00007ffd6020d420 R08: 00007ffd6020d420 R09: 00007ffd6020d420
R10: 00007ffd6020d420 R11: 0000000000000202 R12: 000000000040acb0
R13: 0000000000000000 R14: 00000000004c4018 R15: 0000000000000000
 </TASK>
INFO: task repro:9793 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:repro           state:D stack:28552 pid:9793  tgid:9793  ppid:9790   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __lock_acquire+0x490/0x2610
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 blk_mq_get_tag+0x566/0xae0
 ? __pfx_blk_mq_get_tag+0x10/0x10
 ? __pfx_autoremove_wake_function+0x10/0x10
 __blk_mq_alloc_requests+0xaf6/0x1640
 ? __pfx___blk_mq_alloc_requests+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 blk_mq_alloc_request+0x791/0x990
 ? __pfx_blk_mq_alloc_request+0x10/0x10
 ? __might_fault+0x138/0x190
 scsi_alloc_request+0x23/0x60
 scsi_bsg_sg_io_fn+0x155/0xb50
 ? __pfx_scsi_bsg_sg_io_fn+0x10/0x10
 bsg_sg_io+0x1a3/0x2a0
 ? __pfx_bsg_sg_io+0x10/0x10
 ? __x64_sys_openat+0x13f/0x1f0
 bsg_ioctl+0x578/0x5e0
 ? __pfx_bsg_ioctl+0x10/0x10
 __x64_sys_ioctl+0x18f/0x210
 do_syscall_64+0xcb/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x451d2d
RSP: 002b:00007ffd6020d408 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400518 RCX: 0000000000451d2d
RDX: 0000200000000480 RSI: 0000000000002285 RDI: 0000000000000004
RBP: 00007ffd6020d420 R08: 00007ffd6020d420 R09: 00007ffd6020d420
R10: 00007ffd6020d420 R11: 0000000000000202 R12: 000000000040acb0
R13: 0000000000000000 R14: 00000000004c4018 R15: 0000000000000000
 </TASK>
INFO: task repro:9794 blocked for more than 143 seconds.
      Not tainted 6.19.0-rc4 #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:repro           state:D stack:28552 pid:9794  tgid:9794  ppid:9784   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 ? __schedule+0xf48/0x5f90
 __schedule+0xfc8/0x5f90
 ? __lock_acquire+0x490/0x2610
 ? __pfx___schedule+0x10/0x10
 ? schedule+0x2d6/0x3a0
 schedule+0xe7/0x3a0
 io_schedule+0xbf/0x130
 blk_mq_get_tag+0x566/0xae0
 ? __pfx_blk_mq_get_tag+0x10/0x10
 ? __pfx_autoremove_wake_function+0x10/0x10
 __blk_mq_alloc_requests+0xaf6/0x1640
 ? __pfx___blk_mq_alloc_requests+0x10/0x10
 ? __lock_acquire+0x490/0x2610
 blk_mq_alloc_request+0x791/0x990
 ? __pfx_blk_mq_alloc_request+0x10/0x10
 ? __might_fault+0x138/0x190
 scsi_alloc_request+0x23/0x60
 scsi_bsg_sg_io_fn+0x155/0xb50
 ? __pfx_scsi_bsg_sg_io_fn+0x10/0x10
 bsg_sg_io+0x1a3/0x2a0
 ? __pfx_bsg_sg_io+0x10/0x10
 ? __x64_sys_openat+0x13f/0x1f0
 bsg_ioctl+0x578/0x5e0
 ? __pfx_bsg_ioctl+0x10/0x10
 __x64_sys_ioctl+0x18f/0x210
 do_syscall_64+0xcb/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x451d2d
RSP: 002b:00007ffd6020d408 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400518 RCX: 0000000000451d2d
RDX: 0000200000000480 RSI: 0000000000002285 RDI: 0000000000000004
RBP: 00007ffd6020d420 R08: 00007ffd6020d420 R09: 00007ffd6020d420
R10: 00007ffd6020d420 R11: 0000000000000202 R12: 000000000040acb0
R13: 0000000000000000 R14: 00000000004c4018 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/34:
 #0: ffffffff8e1c86a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0
4 locks held by kworker/1:1/52:
 #0: ffff88801b46d948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b00
 #1: ffffc9000068fca0 ((work_completion)(&(&ap->scsi_rescan_task)->work)){+.+.}-{0:0}, at: process_one_work+0x8ec/0x1b00
 #2: ffff888040bc4760 (&ap->scsi_scan_mutex){+.+.}-{4:4}, at: ata_scsi_dev_rescan+0x3c/0x430
 #3: ffff8880451a6380 (&dev->mutex){....}-{4:4}, at: scsi_rescan_device+0x27/0x340
4 locks held by kworker/0:2/99:
 #0: ffff88801b46d948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b00
 #1: ffffc9000162fca0 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8ec/0x1b00
 #2: ffff88801cb55280 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_damage_work+0x9f/0x5d0
 #3: ffff888021ae0128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x21/0x80
4 locks held by kworker/u9:12/2982:
 #0: ffff88801bf89148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b00
 #1: ffffc900069a7ca0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8ec/0x1b00
 #2: ffff888045b600e0 (&type->s_umount_key#44){++++}-{4:4}, at: super_trylock_shared+0x21/0x100
 #3: ffff8880452c2b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x242/0x5b0
3 locks held by systemd-journal/5222:
 #0: ffff888043addd08 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0x118/0x590
 #1: ffff888045b60518 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x17a/0x390
 #2: ffff8880452c6950 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xe33/0x12d0
3 locks held by kworker/u9:31/8341:
 #0: ffff88801bf89148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b00
 #1: ffffc9000a05fca0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8ec/0x1b00
 #2: ffff88801ce9a0e0 (&type->s_umount_key#46){.+.+}-{4:4}, at: super_trylock_shared+0x21/0x100
4 locks held by kworker/u9:33/8733:
 #0: ffff88801bf89148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b00
 #1: ffffc9001086fca0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8ec/0x1b00
 #2: ffff888045b600e0 (&type->s_umount_key#44){++++}-{4:4}, at: super_trylock_shared+0x21/0x100
 #3: ffff8880452c2b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x242/0x5b0
1 lock held by in:imklog/9087:
 #0: ffff8880259d2b78 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a0/0x370
4 locks held by rs:main Q:Reg/9088:
 #0: ffff8880441b90b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a0/0x370
 #1: ffff888045b60420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x121/0x240
 #2: ffff8880457faa60 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: ext4_buffered_write_iter+0xab/0x430
 #3: ffff8880452c6950 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xe33/0x12d0

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 34 Comm: khungtaskd Not tainted 6.19.0-rc4 #8 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x116/0x1b0
 nmi_cpu_backtrace+0x2a0/0x350
 ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
 nmi_trigger_cpumask_backtrace+0x29c/0x300
 sys_info+0x133/0x180
 watchdog+0xe57/0x1180
 ? __pfx_watchdog+0x10/0x10
 kthread+0x3d0/0x780
 ? __pfx_kthread+0x10/0x10
 ? _raw_spin_unlock_irq+0x23/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x966/0xaf0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x76c/0x10d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc4 #8 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:pv_native_safe_halt+0x1e/0x30
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 eb 0c 0f 1f 44 00 00 0f 00 2d b9 40 12 00 0f 1f 44 00 00 fb f4 <e9> cd 44 03 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90
RSP: 0018:ffffffff8de07de8 EFLAGS: 00000286
RAX: 000000000018fb7b RBX: 0000000000000000 RCX: ffffffff8b582239
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed10056c673d
R10: ffff88802b6339eb R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff906883d0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888097d25000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c40f0 CR3: 000000000df84000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 default_idle+0x1d/0x30
 default_idle_call+0x6c/0xb0
 do_idle+0x36f/0x4d0
 ? __pfx___schedule+0x10/0x10
 ? __pfx_do_idle+0x10/0x10
 ? find_held_lock+0x2b/0x80
 cpu_startup_entry+0x4f/0x60
 rest_init+0x16b/0x2b0
 ? acpi_subsystem_init+0x133/0x180
 ? __pfx_x86_late_time_init+0x10/0x10
 start_kernel+0x3e8/0x4c0
 x86_64_start_reservations+0x18/0x30
 x86_64_start_kernel+0x133/0x190
 common_startup_64+0x13e/0x148
 </TASK>

Thanks,
JiaHong Su
