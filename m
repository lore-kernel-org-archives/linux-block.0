Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C06FA372A
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADCC20872
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 16:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436689AbfJQQtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:49:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394336AbfJQQtK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 12:49:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B7B230832C0;
        Thu, 17 Oct 2019 16:49:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E9DF5C1B5;
        Thu, 17 Oct 2019 16:49:08 +0000 (UTC)
Date:   Thu, 17 Oct 2019 17:49:08 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Mike Christie <mchristi@redhat.com>,
        syzbot <syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com>,
        axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in nbd_ioctl
Message-ID: <20191017164908.GC3888@redhat.com>
References: <000000000000b1b1ee0593cce78f@google.com>
 <5D93C2DD.10103@redhat.com>
 <20191017140330.GB25667@redhat.com>
 <5DA88D2F.7080907@redhat.com>
 <20191017162829.GA3888@redhat.com>
 <20191017163634.GD726@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017163634.GD726@sol.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 17 Oct 2019 16:49:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 17, 2019 at 09:36:34AM -0700, Eric Biggers wrote:
> On Thu, Oct 17, 2019 at 05:28:29PM +0100, Richard W.M. Jones wrote:
> > On Thu, Oct 17, 2019 at 10:47:59AM -0500, Mike Christie wrote:
> > > On 10/17/2019 09:03 AM, Richard W.M. Jones wrote:
> > > > On Tue, Oct 01, 2019 at 04:19:25PM -0500, Mike Christie wrote:
> > > >> Hey Josef and nbd list,
> > > >>
> > > >> I had a question about if there are any socket family restrictions for nbd?
> > > > 
> > > > In normal circumstances, in userspace, the NBD protocol would only be
> > > > used over AF_UNIX or AF_INET/AF_INET6.
> > > > 
> > > > There's a bit of confusion because netlink is used by nbd-client to
> > > > configure the NBD device, setting things like block size and timeouts
> > > > (instead of ioctl which is deprecated).  I think you don't mean this
> > > > use of netlink?
> > > 
> > > I didn't. It looks like it is just a bad test.
> > > 
> > > For the automated test in this thread the test created a AF_NETLINK
> > > socket and passed it into the NBD_SET_SOCK ioctl. That is what got used
> > > for the NBD_DO_IT ioctl.
> > > 
> > > I was not sure if the test creator picked any old socket and it just
> > > happened to pick one nbd never supported, or it was trying to simulate
> > > sockets that did not support the shutdown method.
> > > 
> > > I attached the automated test that got run (test.c).
> > 
> > I'd say it sounds like a bad test, but I'm not familiar with syzkaller
> > nor how / from where it generates these tests.  Did someone report a
> > bug and then syzkaller wrote this test?
>
> It's an automatically generated fuzz test.
>
> There's rarely any such thing as a "bad" fuzz test.  If userspace
> can do something that causes the kernel to crash or hang, it's a
> kernel bug, with very few exceptions (e.g. like writing to
> /dev/mem).
>
> If there are cases that aren't supported, like sockets that don't
> support a certain function or whatever, then the code needs to check
> for those cases and return an error, not hang the kernel.

Oh I see.  In that case I agree, although I believe this is a
root-only API and root has a lot of ways to crash the kernel, but sure
it could be fixed to restrict sockets to one of:

 - AF_LOCAL or AF_UNIX
 - AF_INET or AF_INET6
 - AF_INET*_SDP (? no idea what this is, but it's used by nbd-client)

Here are some ways NBD is used in real code:

libnbd$ git grep AF_
fuzzing/libnbd-fuzz-wrapper.c:  if (socketpair (AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0, sv) == -1) {
generator/states-connect-socket-activation.c:  s = socket (AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0);
generator/states-connect-socket-activation.c:  addr.sun_family = AF_UNIX;
generator/states-connect.c:  fd = socket (AF_UNIX, SOCK_STREAM|SOCK_NONBLOCK|SOCK_CLOEXEC, 0);
generator/states-connect.c:  struct sockaddr_un sun = { .sun_family = AF_UNIX };
generator/states-connect.c:  if (socketpair (AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0, sv) == -1) {


nbdkit$ git grep AF_
plugins/info/info.c:  case AF_INET:
plugins/info/info.c:    if (inet_ntop (AF_INET, &addr->sin_addr,
plugins/info/info.c:  case AF_INET6:
plugins/info/info.c:    if (inet_ntop (AF_INET6, &addr6->sin6_addr,
plugins/info/info.c:  case AF_UNIX:
plugins/nbd/nbd-standalone.c:  struct sockaddr_un sock = { .sun_family = AF_UNIX };
plugins/nbd/nbd-standalone.c:  fd = socket (AF_UNIX, SOCK_STREAM, 0);
server/sockets.c:  sock = socket (AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0);
server/sockets.c:  sock = set_cloexec (socket (AF_UNIX, SOCK_STREAM, 0));
server/sockets.c:  addr.sun_family = AF_UNIX;
tests/test-layers.c:  if (socketpair (AF_LOCAL, SOCK_STREAM, 0, sfd) == -1) {
tests/test-socket-activation.c:  sock = socket (AF_UNIX, SOCK_STREAM /* NB do not use SOCK_CLOEXEC */, 0);
tests/test-socket-activation.c:  addr.sun_family = AF_UNIX;
tests/test-socket-activation.c:  sock = socket (AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0);
tests/web-server.c:  listen_sock = socket (AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0);
tests/web-server.c:  addr.sun_family = AF_UNIX;

nbd$ git grep AF_
gznbd/gznbd.c:  if(socketpair(AF_UNIX, SOCK_STREAM, 0, pr)){
nbd-client.c:           if (ai->ai_family == AF_INET)
nbd-client.c:                   ai->ai_family = AF_INET_SDP;
nbd-client.c:           else (ai->ai_family == AF_INET6)
nbd-client.c:                   ai->ai_family = AF_INET6_SDP;
nbd-client.c:   un_addr.sun_family = AF_UNIX;
nbd-client.c:   if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
nbd-client.c:           if (socketpair(AF_UNIX, SOCK_STREAM, 0, plainfd) < 0)
nbd-server.c:   if(netaddr.ss_family == AF_UNIX) {
nbd-server.c:           client->clientaddr.ss_family = AF_UNIX;
nbd-server.c:                   if(client->clientaddr.ss_family == AF_UNIX) {
nbd-server.c:                           assert((ai->ai_family == AF_INET) || (ai->ai_family == AF_INET6));
nbd-server.c:                           if(ai->ai_family == AF_INET) {
nbd-server.c:                           } else if(ai->ai_family == AF_INET6) {
nbd-server.c:   socketpair(AF_UNIX, SOCK_STREAM, 0, sockets);
nbd-server.c:   sa.sun_family = AF_UNIX;
nbd-server.c:   sock = socket(AF_UNIX, SOCK_STREAM, 0);
nbdsrv.c:       int addrlen = addr->sa_family == AF_INET ? 4 : 16;
nbdsrv.c:               assert(addr->sa_family == AF_INET || addr->sa_family == AF_INET6);
nbdsrv.c:                       case AF_INET:
nbdsrv.c:                       case AF_INET6:
tests/code/trim.c:      socketpair(AF_UNIX, SOCK_STREAM, AF_UNIX, spair);
tests/run/nbd-tester-client.c:          if (socketpair(AF_UNIX, SOCK_STREAM, 0, plainfd) < 0) {
tests/run/nbd-tester-client.c:  if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
tests/run/nbd-tester-client.c:  addr.sun_family = AF_UNIX;
tests/run/nbd-tester-client.c:  addr.sin_family = AF_INET;
tests/run/nbd-tester-client.c:  if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) == -1) {


qemu-nbd is a bit hard to grep like this, but it only supports
Unix domain sockets or TCP/IP.


Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
