Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFCC4332F
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 03:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiL0Ddo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Dec 2022 22:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiL0Ddn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Dec 2022 22:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A78F25E7
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 19:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672111974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VwOE+F86uWsg5Wnwq09aKncqgVlvCr+KQWK+eRMPdfA=;
        b=Asat/RYIiATEgqnSUZupiSRc8N257lC2kxuXaHnsR8jQw/dm3f23TONN054X1ZmwbJfHv0
        CoOhPdK7tcgHlZauDWshOoEtoacflnxd9nfe++gmxnwCuy2915pCwSb1eQxWVmrkVoirJ1
        12CEe1MiA0QOaBLqTcBQQGVSIMJpPvE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-cRqnW_nrPAqfqiFX-XlIyQ-1; Mon, 26 Dec 2022 22:32:53 -0500
X-MC-Unique: cRqnW_nrPAqfqiFX-XlIyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF4923806647
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 03:32:52 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ADF22166B3F;
        Tue, 27 Dec 2022 03:32:50 +0000 (UTC)
Date:   Tue, 27 Dec 2022 11:32:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changhui Zhong <czhong@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] Unable to handle kernel NULL pointer dereference at
 virtual address 0000000000000058
Message-ID: <Y6pnXGJn6tx+nCH3@T590>
References: <CAGVVp+WS5aHiF2Odc-C+fO56qKyV7vPsPRz35v9eWsPJDNj=ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVVp+WS5aHiF2Odc-C+fO56qKyV7vPsPRz35v9eWsPJDNj=ng@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 26, 2022 at 11:11:44AM +0800, Changhui Zhong wrote:
> Hello,
> Below issue was triggered with ( v6.0.15-996-g988abd970566), pls help check it
> 
> [ 7845.648246] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000058
> [ 7845.648776] Mem abort info:
> [ 7845.648938]   ESR = 0x0000000096000004
> [ 7845.649155]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 7845.649462]   SET = 0, FnV = 0
> [ 7845.649639]   EA = 0, S1PTW = 0
> [ 7845.649821]   FSC = 0x04: level 0 translation fault
> [ 7845.650105] Data abort info:
> [ 7845.650274]   ISV = 0, ISS = 0x00000004
> [ 7845.650496]   CM = 0, WnR = 0
> [ 7845.650670] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103cba000
> [ 7845.651043] [0000000000000058] pgd=0000000000000000, p4d=0000000000000000
> [ 7845.651446] Internal error: Oops: 96000004 [#1] SMP
> [ 7845.651764] Modules linked in: snd_aloop snd_dummy snd_seq
> snd_seq_device snd_pcm snd_timer snd soundcore ansi_cprng crypto_user
> veth vrf ipvlan echainiv esp4 des_generic libdes tun geneve ip6_tables
> ip_vs ip_set xt_sctp nf_conntrack_netlink nft_chain_nat xt_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables
> nfnetlink tcp_dctcp ah6 ah4 binfmt_misc can_j1939 l2tp_core bnep hidp
> can_bcm pptp gre can_raw rfcomm bluetooth ieee802154_socket ieee802154
> af_key qrtr pppoe pppox ppp_generic slhc mpls_router ip_tunnel
> vsock_loopback vmw_vsock_virtio_transport_common
> vmw_vsock_vmci_transport vmw_vmci vsock fcrypt pcbc rxrpc smc ib_core
> kcm can macsec llc sctp ip6_udp_tunnel udp_tunnel mlx4_en mlx4_core
> nfp tls loop nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache
> netfs rfkill sunrpc vfat fat virtio_net net_failover failover fuse
> zram xfs crct10dif_ce polyval_ce virtio_console polyval_generic
> ghash_ce virtio_blk virtio_mmio qemu_fw_cfg [last unloaded: vxlan]
> [ 7845.656785] CPU: 5 PID: 789199 Comm: bash Not tainted 6.0.15 #1
> [ 7845.657126] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [ 7845.657523] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 7845.657932] pc : blk_mq_quiesce_queue+0x50/0xa0

Hi Changhui,

Can you figure out the fault source code by gdb?

gdb vmlinux
gdb> l *(blk_mq_quiesce_queue+0x50)


thanks, 
Ming

