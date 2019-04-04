Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A988C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 19:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2D92075E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 19:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=demfloro.ru header.i=@demfloro.ru header.b="VyYTT/VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfDDTXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:23:05 -0400
Received: from mx.demfloro.ru ([185.52.0.75]:52842 "EHLO mx.demfloro.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfDDTXF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 15:23:05 -0400
Received: from fire.localdomain (unknown [IPv6:2001:470:28:88::100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: demfloro)
        by mx.demfloro.ru (Postfix) with ESMTPSA id 44ZtBt1TlvzB57c;
        Thu,  4 Apr 2019 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru; s=032019;
        t=1554405782; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63g/cWAoNflwlZQm2tGWAfkT/DR+u+GHtae92sla5g4=;
        b=VyYTT/VV88usSWiDDtDFyzv75g/AFYiqJWdVQLXhFVEA19NDOYdLdX5Aqc7f2cqqWLeWeM
        7CGciGzgyk4Oa/epEz48zR8t/zbF840LR9QjRS8fqmTvT3DGP9kSQN+SRKb8VIahdlk6iY
        W5ZhDhZ9ZKk80yn2kmB1bXREwa5kUVjoSZAcpHf6xPKuyYGNH8a+C88BMaYLZz9toddU1F
        QvXRuT/PRWipOK1/H1N6omTv7Cw2QFBLzaxWw2ldLzpHbi873HJ7b1hBFCzRzgb3EowHjp
        CuoQi6EstDYYswYvmAaaP2r/hTPF9z3CXf5INcSnKXZk8MTwEVGhymCXQRG0Wg==
Date:   Thu, 4 Apr 2019 22:22:57 +0300
From:   Dmitrii Tcvetkov <demfloro@demfloro.ru>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
Message-ID: <20190404222257.0cfb1130@fire.localdomain>
In-Reply-To: <EBC090F1-72C0-4794-91CC-37F9A2A1DEFB@linaro.org>
References: <20190329160227.7d55c8dd@fire.localdomain>
        <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
        <626EAE58-63C1-4ABA-9040-9D9A61F74A0D@linaro.org>
        <20190401115509.76310e03@fire.localdomain>
        <84B0CA50-0ED8-4171-8007-19EA43951735@linaro.org>
        <20190401122233.3e861312@fire.localdomain>
        <EBC090F1-72C0-4794-91CC-37F9A2A1DEFB@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/IJ.6CVMsu2MF7LCxrnNrmoU"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru;
        s=arc032019; t=1554405782;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63g/cWAoNflwlZQm2tGWAfkT/DR+u+GHtae92sla5g4=;
        b=WQWph2OhK9Hxh1EXVBvmrTLevQWbTBMoXzt/5P42up1gurx8EJGAAD7p1jYaGwUzP+lRGQ
        iDkXAedxW0/p8cQ1AHD3rB7DPnTlmiffOQNPtd1tu9UhAfqtUDhMf1/K/SfcGcKe0/cM/C
        tnEKf7OqekE9ZnuWgq4WiJ56V2EqC0clUJ0l9mmNQuKq3GKYVTzhs4JspHOvUJVYmTNT6E
        VezvK5IurW6EKBMeD+oLCGD3wSnRzAOSe7GYURTmEKqkbqIPXkx/4vwznA5er+W1kf+hC7
        r/ysvsU8kKIp77HKXMJMdhQowQHHhIMequ+4whN7MVGo5WdKvLknku70fW5iKA==
ARC-Seal: i=1; s=arc032019; d=demfloro.ru; t=1554405782; a=rsa-sha256;
        cv=none;
        b=tqWtjR1uBfdBhYCB/emqDMK2o61mL/kbfioLlMZMWHmJ1VAb+Yq5zWio7WGI8R+ydZREe1
        Q7TTJDkX72jf0zQ+hovycALoffXoGRGLUbBCu1qZNkPVdJyo9P+G8yJ1YINNOwXBK5xe2V
        7YS+ZuSeGhuF5L/XXZ1ZNCqeDnk/xSkByWJ8vDzdrmF7hnBxL7tQ3xvkL9oSyogiwxp85L
        7PfeHBGqDsF5IFnz6zbuXXvq363bul0FXqwSRbsoGQcFaE6x8Kxwj1CpJbYDTD3kvH5rs/
        u2VKu0ZnkFKT7Kib34XekbZVCyLU0QqF/Cr5abGCJ1zPR+R9unrApzVuEv0qLw==
ARC-Authentication-Results: i=1;
        mx.demfloro.ru;
        auth=pass smtp.auth=demfloro smtp.mailfrom=demfloro@demfloro.ru
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--MP_/IJ.6CVMsu2MF7LCxrnNrmoU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 1 Apr 2019 12:35:11 +0200
Paolo Valente <paolo.valente@linaro.org> wrote:

> 
> 
> > Il giorno 1 apr 2019, alle ore 11:22, Dmitrii Tcvetkov
> > <demfloro@demfloro.ru> ha scritto:
> > 
> > On Mon, 1 Apr 2019 11:01:27 +0200
> > Paolo Valente <paolo.valente@linaro.org> wrote:
> >> Ok, thank you. Could you please do a
> >> 
> >> list *(bfq_bfqq_expire+0x1f3)
> >> 
> >> for me?
> >> 
> >> Thanks,
> >> Paolo
> >> 
> >>> 
> >>> <gpf.txt><gpf-w-bfq-group-iosched.txt><config.txt>
> > 
> > Reading symbols from vmlinux...done.
> > (gdb) list *(bfq_bfqq_expire+0x1f3)
> > 0xffffffff813d02c3 is in bfq_bfqq_expire (block/bfq-iosched.c:3390).
> > 3385             * even in case bfqq and thus parent entities go on
> > receiving 3386             * service with the same budget.
> > 3387             */
> > 3388            entity = entity->parent;
> > 3389            for_each_entity(entity)
> > 3390                    entity->service = 0;
> > 3391    }
> > 3392
> > 3393    /*
> > 3394     * Budget timeout is not implemented through a dedicated
> > timer, but
> 
> Thank you very much.  Unfortunately this doesn't ring any bell.  I'm
> trying to reproduce the failure.  It will probably take a little
> time.  If I don't make it, I'll ask you to kindly retry after applying
> some instrumentation patch.
> 

I looked at what git is doing just before panic and it's doing a lot of
lstat() syscalls on working tree.

I've attached a python script which reproduces the crash in about
10 seconds after it prepares testdir, git checkout origin/linux-5.0.y
reproduces it in about 2 seconds. I have to use multiprocessing Pool as
I couldn't reproduce the crash using ThreadPool, probably due to Python
GIL.


--MP_/IJ.6CVMsu2MF7LCxrnNrmoU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=crash.py

#!/usr/bin/env python3

from glob import glob
from os import lstat,mkdir
from random import randint
from os.path import isdir,exists
from pathlib import Path
from time import sleep
from subprocess import run
from multiprocessing import Pool

def drop_caches():
    with open('/proc/sys/vm/drop_caches','w') as f:
        f.write('3')

def enable_bfq():
    with open('/sys/block/sda/queue/scheduler','w') as f:
        f.write('bfq')

def sync():
    run(('sync'))

def prepare_tree(name):
    def populate(dir, depth=6):
        if not depth:
            return
        for fname in range(1,20):
            if randint(0,100) > 80:
                dirname = "{}{}/".format(dir,fname)
                mkdir(dirname)
                populate(dirname, depth - 1)
                continue
            fname = "{}{}".format(dir, fname)
            Path(fname).touch(exist_ok=True)
            
    if not isdir(name):
        mkdir(name)
    if not name.endswith('/'):
        name = '{}/'.format(name)
    populate(name)
    
        

def traverse(dir):
    drop_caches()
    for inode in glob("{}/*".format(dir)):
        if isdir(inode):
            traverse(inode)
        else:
            lstat(inode)
            if randint(0,10) > 6:
                sleep(0)

def main():
    nproc = 16
    dirname = 'testdir'
    if not exists(dirname):
        prepare_tree(dirname)
    sync()
    drop_caches()
    enable_bfq()
    drop_caches()

    with Pool(nproc) as pool:
        dirs = (dirname,) * nproc
        pool.map(traverse,dirs)
            
main()

--MP_/IJ.6CVMsu2MF7LCxrnNrmoU--
